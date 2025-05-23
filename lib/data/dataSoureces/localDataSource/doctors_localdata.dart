import 'dart:convert';
import 'dart:developer';

import '../../../core/error/exception.dart';
import '../../../core/services/services.dart';
import '../../model/doctor_model.dart';

abstract class DoctorsLocalData {
  Future cacheDoctors(DoctorModel drugs);
  Future<DoctorModel> getCachedDoctors();
}

class DoctorsLocalDataImp implements DoctorsLocalData {
  final MyServices myServices;
  DoctorsLocalDataImp({required this.myServices});

  @override
  Future cacheDoctors(DoctorModel drugs) async {
    await myServices.sharedPreferences
        .setString('DOCTORS_CACHE', jsonEncode(drugs));
  }

  @override
  Future<DoctorModel> getCachedDoctors() async {
    final cachedData = myServices.sharedPreferences.getString('DOCTORS_CACHE');
    if (cachedData != null) {
      return DoctorModel.fromJson(jsonDecode(cachedData));
    } else {
      log("============\n Empty Cached DOCTORS Data  \n============");
      throw EmptyCacheException();
    }
  }
}
