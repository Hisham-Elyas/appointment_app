import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../data/model/doctor_model.dart';

class DoctorController extends GetxController {
  late StatusRequest statusReq;
  // final DoctorsRepoImpHttp drugsRepo = Get.find();
  @override
  void onInit() {
    super.onInit();
    // getAllDoctors();
    getAllDoctors();
  }

  final List<Doctor> doctorlist = [];

  List<Doctor>? filter(String query) {
    List<Doctor>? filter = [];

    if (query == "") {
      return doctorlist;
    } else {
      filter = doctorlist.where((element) {
        return element.name!.toUpperCase().startsWith(query.toUpperCase());
      }).toList();

      return filter;
    }
  }

  Future<void> getAllDoctors() async {
    try {
      statusReq = StatusRequest.loading;
      update();

      final snapshot =
          await FirebaseFirestore.instance.collection('doctors').get();

      doctorlist.clear();
      doctorlist.addAll(snapshot.docs.map((doc) {
        final data = doc.data();
        return Doctor.fromMap(data);
      }));

      statusReq = StatusRequest.success;
      update();
    } catch (e) {
      statusReq = StatusRequest.serverFailure;
      update();
      print(e);
      Get.snackbar("⚠️ Error", e.toString());
    }
  }

  List<Doctor?> filterDoctors(String specialty) {
    List<Doctor?> newlist = [];
    for (var el in doctorlist) {
      if (el.specialty == specialty) {
        newlist.add(el);
      }
    }

    return newlist;
  }
}
