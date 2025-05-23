import 'dart:convert';
import 'dart:developer';

import '../../../core/error/exception.dart';
import '../../../core/services/services.dart';
import '../../model/hospital_model.dart';

abstract class HospitalLocaldata {
  Future cacheHospital(HospitalModelList hospitals);
  Future<HospitalModelList> getCachedHospital();
}

class HospitalLocalDataImp implements HospitalLocaldata {
  final MyServices myServices;
  HospitalLocalDataImp({required this.myServices});

  @override
  Future cacheHospital(HospitalModelList hospitals) async {
    await myServices.sharedPreferences
        .setString('HOSPITAL_CACHE', jsonEncode(hospitals));
  }

  @override
  Future<HospitalModelList> getCachedHospital() async {
    final cachedData = myServices.sharedPreferences.getString('HOSPITAL_CACHE');
    if (cachedData != null) {
      return HospitalModelList.fromJson(jsonDecode(cachedData));
    } else {
      log("============\n Empty Cached Hospital Data  \n============");
      throw EmptyCacheException();
    }
  }
}
