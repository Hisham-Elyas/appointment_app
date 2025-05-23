import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/string.dart';
import '../core/functions/coustom_overlay.dart';
import '../data/repositories/auth_repo.dart';

class ResstPasswordController extends GetxController {
  late final GlobalKey<FormState> formKeyEmail = GlobalKey();
  late final GlobalKey<FormState> formKeyPass = GlobalKey();
  final AuthRepoImpFirebase authRepo = Get.find();

  late String email;
  late String codeVerify;
  late String passwordOne;
  late String passwordTow;

  Future<void> reSetPassword() async {
    if (!formKeyEmail.currentState!.validate()) {
      // Invalid!
      return;
    }
    formKeyEmail.currentState!.save();

    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.reSetPassword(email: email);
        if (isSuccess) {
          Get.toNamed(AppRoutes.getVerifyCodeScreen());
        }
      },
    );
  }

  Future<void> submitVerifyCode() async {
    log(codeVerify);
    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.verifyCode(code: codeVerify);
        if (isSuccess) {
          Get.toNamed(AppRoutes.getCreateNewPasswordScreen());
        }
      },
    );
  }

  Future<void> reSendVerifyCode() async {
    showOverlay(
      asyncFunction: () async {
        await authRepo.reSendVerifyCode(email: email);
      },
    );
  }

  Future<void> submitPass() async {
    if (!formKeyPass.currentState!.validate()) {
      // Invalid!
      return;
    }
    formKeyPass.currentState!.save();

    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.setNewPassword(
            code: codeVerify, newPassword: passwordTow);
        if (isSuccess) {
          Get.offAllNamed(AppRoutes.getHomeScreen());
        }
      },
    );
  }

  bool isShowPass = true;
  void showPassword() {
    isShowPass = !isShowPass;
    update();
    Future.delayed(const Duration(seconds: 2), () {
      isShowPass = !isShowPass;
      update();
    });
  }

  set setEmail(val) {
    email = val;
  }

  set setPasswordTow(val) {
    passwordTow = val;
  }

  set setpasswordOne(val) {
    passwordOne = val;
  }

  bool isvalidEmail = false;
  bool isvalidpasswordOne = false;
  bool isvalidpassword = false;

  String? emailvalidator(String? val) {
    isvalidEmail = false;
    if (val != null) {
      if (val.isEmpty) {
        return Type_your_email_adress.tr;
      } else if (!GetUtils.isEmail(val)) {
        return Type_in_valid_email_adress.tr;
      } else {
        isvalidEmail = true;
        update();
        return null;
      }
    }
    return null;
  }

  String? passwordvalidator(val, number) {
    isvalidpassword = false;
    if (val.isEmpty) {
      return Enter_your_password.tr;
    } else if (val.length < 6) {
      return Password_can_not_be_less_than_six_characters.tr;
    } else {
      if (number == 2 && val != passwordOne) {
        return Password_not_match.tr;
      } else {
        passwordOne = val;
        isvalidpassword = true;
        update();

        return null;
      }
    }
  }
}
