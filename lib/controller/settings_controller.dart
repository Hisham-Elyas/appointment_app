import 'dart:developer';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/constant/string.dart';
import '../core/localization/changelocal_controller.dart';
import 'location_controller.dart';

class SettingsController extends GetxController {
  final LocaleController lang = Get.find();
  final LocationController location = Get.find();

  bool isDarkMode = Get.isDarkMode;

  void switchDarkMode({required bool value}) {
    lang.changeTheme();
    isDarkMode = value;

    update();
  }

  void showFeedback() {
    BetterFeedback.of(Get.context!).show(
      (feedback) {
        // upload to server, share whatever
        // for example purposes just show it to the user

        log('Feedback text:');
        log(feedback.text);
        log('Size of image: ${feedback.screenshot.length}');
        if (feedback.extra != null) {
          log('Extras: ${feedback.extra!.toString()}');
        }
      },
    );
  }

  void switchLang() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        color: Theme.of(Get.context!).colorScheme.surface,
      ),
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              lang.changLang(langCode: 'en');
              Get.close(1);
            },
            leading: Text(
              English.tr,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context!).textTheme.displayLarge!.color),
            ),
          ),
          ListTile(
            onTap: () {
              lang.changLang(langCode: 'ar');
              Get.close(1);
            },
            leading: Text(
              Arabic.tr,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context!).textTheme.displayLarge!.color),
            ),
          ),
        ],
      ),
    ));
  }
}
