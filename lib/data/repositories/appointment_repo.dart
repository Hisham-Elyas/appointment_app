import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../core/class/enums.dart';
import '../../core/constant/string.dart';
import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_coustom_snackbar.dart';
import '../../core/functions/show_errormessage.dart';
import '../model/apointment_model.dart';

abstract class AppointmentRepo {
  Future<Either<StatusRequest, AppointmentModel>> getAllAppointment(
      {required String userId});
  Future<bool> addAppointment({required Appointment appointment});
  Future<bool> updateAppointment({required Appointment appointment});
  Future<bool> deleteAppointment({required appointmentId});
}

class AppointmentRepoImpHttp implements AppointmentRepo {
  // final AppointmentLocalDataImp appointmentLocalData;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collection = 'appointments';

  AppointmentRepoImpHttp(
      // {
      // required this.appointmentLocalData,
      // }
      );

  @override
  Future<Either<StatusRequest, AppointmentModel>> getAllAppointment(
      {required String userId}) async {
    if (await ckeckInternet()) {
      try {
        final snapshot = await firestore
            .collection(_collection)
            .where('userId', isEqualTo: userId)
            .get();

        final appointments = snapshot.docs.map((doc) {
          final data = doc.data();
          print(doc.id);
          return Appointment.fromMap({...data}, id: doc.id);
        }).toList();

        final result = AppointmentModel(
            count: appointments.length, appointment: appointments);

        // appointmentLocalData.cachegetAppointment(
        //     key: 'APPOINTMENT_CACHE', appointment: result);

        log('from Firebase  ==> getAllAppointment');
        return right(result);
      } catch (e) {
        log('Firebase Error => $e');
        return left(StatusRequest.serverFailure);
      }
    } else {
      return left(StatusRequest.emptyCache);
    }
  }

  @override
  Future<bool> addAppointment({required Appointment appointment}) async {
    if (await ckeckInternet()) {
      try {
        await firestore.collection(_collection).add(appointment.toMap());
        log('to Firebase  ==> addAppointment');
        showCustomSnackBar(message: Appointment_Added.tr, title: Done.tr);
        return true;
      } catch (e) {
        showErrorMessage(e.toString());
        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<bool> updateAppointment({required Appointment appointment}) async {
    if (await ckeckInternet()) {
      try {
        if (appointment.id != null) {
          await firestore
              .collection(_collection)
              .doc(appointment.id)
              .update(appointment.toMap());

          log('to Firebase  ==> updateAppointment');
          showCustomSnackBar(message: Appointment_Updated.tr, title: Done.tr);
          return true;
        } else {
          throw Exception("Appointment ID is null");
        }
      } catch (e) {
        showErrorMessage(e.toString());
        print(e);
        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<bool> deleteAppointment({required appointmentId}) async {
    if (await ckeckInternet()) {
      try {
        await firestore.collection(_collection).doc(appointmentId).delete();
        log('to Firebase  ==> deleteAppointment');
        showCustomSnackBar(message: Appointment_Canceled.tr, title: Done.tr);
        return true;
      } catch (e) {
        showErrorMessage(e.toString());
        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }
}
