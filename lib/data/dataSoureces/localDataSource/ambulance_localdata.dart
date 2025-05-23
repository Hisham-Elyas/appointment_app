import 'dart:convert';
import 'dart:developer';

import '../../../core/error/exception.dart';
import '../../../core/services/services.dart';
import '../../model/ambulance_model.dart';

abstract class AmbulanceLocaldata {
  Future cacheAmbulance(AmbulanceModelList ambulances);
  Future<AmbulanceModelList> getCachedAmbulance();
}

class AmbulanceLocalDataImp implements AmbulanceLocaldata {
  final MyServices myServices;
  AmbulanceLocalDataImp({required this.myServices});

  @override
  Future cacheAmbulance(AmbulanceModelList drugs) async {
    await myServices.sharedPreferences
        .setString('AMBULANCE_CACHE', jsonEncode(drugs));
  }

  @override
  Future<AmbulanceModelList> getCachedAmbulance() async {
    final cachedData =
        myServices.sharedPreferences.getString('AMBULANCE_CACHE');
    if (cachedData != null) {
      return AmbulanceModelList.fromJson(jsonDecode(cachedData));
    } else {
      log("============\n Empty Cached Ambulance Data  \n============");
      throw EmptyCacheException();
    }
  }
}
