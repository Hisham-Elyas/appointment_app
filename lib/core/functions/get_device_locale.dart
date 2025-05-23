import 'package:get/get.dart';

import '../services/services.dart';

getdeviceLocale({required en, required ar}) {
  MyServices myServices = Get.find();
  String? sharedlang = myServices.sharedPreferences.getString("lang");
  // String deviceLocale = Get.deviceLocale!.languageCode;
  if (sharedlang == "en") {
    return en;
  } else if (sharedlang == "ar") {
    return ar;
  } else {
    return en;
  }
}
