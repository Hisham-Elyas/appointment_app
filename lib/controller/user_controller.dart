import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../core/constant/routes.dart';
import '../core/functions/coustom_overlay.dart';
import '../core/functions/show_coustom_snackbar.dart';
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
      userInf = await getUserInfo();
      // print(userInf.userId);
      if (userInf.userId != null) {
        services.sharedPreferences
            .setString('user_info', jsonEncode(userInf.toMap()));
      }
      update();
      // logeOut();
    }
  }

  final h = const Color(0x0fffffff);
  UserModel userInf = UserModel(email: '', userName: '');
  final AuthRepoImpFirebase authRepo = Get.find();
  StatusRequest statusRequest = StatusRequest.loading;

  logeOut() async {
    showOverlay(
      asyncFunction: () async {
        await authRepo.logeOut();

        await Future.delayed(const Duration(seconds: 3));
        Get.offAllNamed(AppRoutes.getOnBoardingn());
      },
    );
  }

  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel> getUserInfo() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data.containsKey('user_info')) {
          final userMap = data['user_info'] as Map<String, dynamic>;
          final user = UserModel.fromMap(userMap);
          userInf = user;
          final MyServices services = Get.find();
          services.sharedPreferences
              .setString('user_info', jsonEncode(user.toMap()));
          statusRequest = StatusRequest.success;
          update();
          return user;
        }
      }
      statusRequest = StatusRequest.serverFailure;
      update();
    } on FirebaseException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'Auth Error', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      statusRequest = StatusRequest.serverFailure;
      update();
      return UserModel(email: '', userName: '');
    } catch (e) {
      printError(info: e.toString());
      statusRequest = StatusRequest.serverFailure;
      update();
      return UserModel(email: '', userName: '');
    }
    statusRequest = StatusRequest.serverFailure;
    update();
    return UserModel(email: '', userName: '');
  }
}
