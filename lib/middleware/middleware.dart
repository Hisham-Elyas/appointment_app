import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/services.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    // myServices.sharedPreferences.clear();
    if (myServices.sharedPreferences.getBool('OnBording') == true) {
      if (myServices.firebaseAuth.currentUser != null) {
        return const RouteSettings(
            name: AppRoutes.homeScreen, arguments: 'User login');
      } else {
        return const RouteSettings(
          name: AppRoutes.loginScreen,
          arguments: 'noGoBack',
        );
      }
    }
    return null;
  }
}
