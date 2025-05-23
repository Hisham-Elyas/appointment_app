import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/functions/coustom_overlay.dart';
import '../core/services/services.dart';
import '../data/model/user_model.dart';
import '../data/repositories/auth_repo.dart';

class UserController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    final MyServices services = Get.find();
    final userdata = services.sharedPreferences.getString('user_info');
    if (userdata != null) {
      userInf = UserModel.fromMap(jsonDecode(userdata));
    } else {
      userInf = UserModel(email: '', userName: '');
      logeOut();
    }
  }

  final h = const Color(0x0fffffff);
  late UserModel userInf;
  final AuthRepoImpFirebase authRepo = Get.find();

  logeOut() async {
    showOverlay(
      asyncFunction: () async {
        await authRepo.logeOut();

        await Future.delayed(const Duration(seconds: 3));
        Get.offAllNamed(AppRoutes.getOnBoardingn());
      },
    );
  }
}
