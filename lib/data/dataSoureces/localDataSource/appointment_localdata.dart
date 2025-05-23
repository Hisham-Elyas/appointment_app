import 'dart:convert';
import 'dart:developer';

import '../../../core/error/exception.dart';
import '../../../core/services/services.dart';
import '../../model/apointment_model.dart';

abstract class AppointmentLocalData {
  Future cachegetAppointment(
      {required String key, required AppointmentModel appointment});
  AppointmentModel getCachedAppointmentModel({required String key});
}

class AppointmentLocalDataImp implements AppointmentLocalData {
  final MyServices myServices;
  AppointmentLocalDataImp({required this.myServices});

  @override
  Future cachegetAppointment(
      {required String key, required AppointmentModel appointment}) async {
    await myServices.sharedPreferences.setString(key, json.encode(appointment));
  }

  @override
  AppointmentModel getCachedAppointmentModel({required String key}) {
    final cachedData = myServices.sharedPreferences.getString(key);
    if (cachedData != null) {
      return AppointmentModel.fromJson(jsonDecode(cachedData));
    } else {
      log("============\n Empty Cached Appointment Data  \n============");
      throw EmptyCacheException();
    }
  }
}
