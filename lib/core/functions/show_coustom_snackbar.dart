import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constant/app_color.dart';
import '../constant/string.dart';

void showCustomSnackBar(
    {required String message,
    bool isError = false,
    String? title,
    void Function(GetSnackBar)? onTap}) {
  Get.closeAllSnackbars();
  Get.snackbar(
    title ?? Errors.tr,
    message,
    onTap: onTap,
    titleText:
        Text(title ?? Errors.tr, style: const TextStyle(color: Colors.white)),
    messageText: Text(message, style: const TextStyle(color: Colors.white)),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? const Color(0xffcf6679) : AppColor.mainColor,
  );
}
