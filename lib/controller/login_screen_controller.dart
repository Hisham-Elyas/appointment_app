import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/string.dart';
import '../core/functions/coustom_overlay.dart';
import '../data/model/user_model.dart';
import '../data/repositories/auth_repo.dart';

class LoginScreenController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey();
  late String email;
  late String password;
  final AuthRepoImpFirebase authRepo = Get.find();
  Future<void> submit() async {
    Get.focusScope!.unfocus();
    if (!loginFormKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    loginFormKey.currentState!.save();
    UserModel user = UserModel(email: email, password: password);
    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.logIn(userModel: user);
        if (isSuccess) {
          Get.offAllNamed(AppRoutes.getOnBoardingn());
        }
      },
    );
  }

  logeOut() async {
    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.logeOut();
        if (isSuccess) {
          await Future.delayed(Duration.zero);
          Get.offAllNamed(AppRoutes.getOnBoardingn());
        }
      },
    );
  }

  signInWithGoogle() async {
    final bool isSuccess = await authRepo.signInWithGoogle();
    if (isSuccess) {
      Get.offAllNamed(AppRoutes.getOnBoardingn());
    }
  }

  bool goBack() {
    final previousRoute = Get.previousRoute;
    final String? goBack = Get.arguments;
    if (goBack != null) {
      return false;
    } else if (previousRoute == '/Start-Screen') {
      return true;
    } else if (previousRoute != '') {
      return false;
    }
    return true;
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

  set setPassword(val) {
    password = val;
  }

  bool isvalidEmail = false;
  bool isvalidpassword = false;
  String? emailvalidator(val) {
    isvalidEmail = false;
    update();
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

  String? passwordvalidator(val) {
    isvalidpassword = false;
    update();
    if (val.isEmpty) {
      return Enter_your_password.tr;
    } else if (val.length < 6) {
      return Password_can_not_be_less_than_six_characters.tr;
    } else {
      isvalidpassword = true;
      update();

      return null;
    }
  }
}
