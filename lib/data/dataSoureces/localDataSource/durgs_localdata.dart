import 'dart:convert';
import 'dart:developer';

import '../../../core/error/exception.dart';
import '../../../core/services/services.dart';
import '../../model/drugs_model.dart';

abstract class DrugsLocalData {
  Future cacheDurgs(DrugsModel drugs);
  Future<DrugsModel> getCachedDurgs();
}

class DrugsLocalDataImp implements DrugsLocalData {
  final MyServices myServices;
  DrugsLocalDataImp({required this.myServices});

  @override
  Future cacheDurgs(DrugsModel drugs) async {
    await myServices.sharedPreferences
        .setString('DRUGS_CACHE', jsonEncode(drugs));
  }

  @override
  Future<DrugsModel> getCachedDurgs() async {
    final cachedData = myServices.sharedPreferences.getString('DRUGS_CACHE');
    if (cachedData != null) {
      return DrugsModel.fromJson(jsonDecode(cachedData));
    } else {
      log("============\n Empty Cached Data \n============");
      throw EmptyCacheException();
    }
  }
}
