import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/functions/show_coustom_snackbar.dart';
import '../../../core/services/services.dart';
import '../../model/user_model.dart';

abstract class AuthRemotData {
  Future<bool> signUp({required UserModel userModel});
  Future<bool> logIn({required UserModel userModel});
  Future<bool> signInWithGoogle();
  Future<bool> logeOut();
  Future<bool> reSetPassword({required String email});
  Future<bool> verifyCode({required String code});
  Future<bool> reSendVerifyCode({required String email});
  Future<bool> setNewPassword({required String code, required newPassword});
}

class AuthRemotDataImpFirebase implements AuthRemotData {
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late final GoogleSignIn googleSignIn = GoogleSignIn();

  // Future<UserModel> getUserInfo() async {
  //   try {
  //     await firebaseFirestore
  //         .collection('users')
  //         .doc(firebaseAuth.currentUser!.uid)
  //         .get()
  //         .then(
  //       (value) {
  //         final userval = value.data()!['user_info'];
  //         print(userval);
  //         print(userval);
  //         print(userval);
  //         print(userval);
  //         print(userval);

  //         return UserModel.fromMap(userval);
  //       },
  //     );
  //   } on FirebaseException catch (e) {
  //     showCustomSnackBar(
  //         message: "${e.message}", title: 'Auth Error', isError: true);

  //     printError(info: "Failed with error '${e.code}' :  ${e.message}");
  //     return UserModel(email: '', userName: '');
  //   } catch (e) {
  //     printError(info: e.toString());

  //     return UserModel(email: '', userName: '');
  //   }
  //   return UserModel(email: '', userName: '');
  // }

  @override
  Future<bool> logeOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.disconnect();
      return true;
    } on FirebaseException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'Auth Error', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    try {
      if (googleUser == null) {
        return false;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final UserModel userModel = UserModel(
          email: userCredential.user!.email!,
          userName: userCredential.user!.displayName,
          userId: userCredential.user!.uid);

      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'user_info': userModel.toMap()}, SetOptions(merge: true));
      final MyServices services = Get.find();
      await services.sharedPreferences
          .setString('user_info', jsonEncode(userModel.toMap()));

      return true;
    } on FirebaseException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'Auth Error', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> signUp({required UserModel userModel}) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password!);
      userModel = UserModel(
          email: userModel.email,
          userName: userModel.userName,
          userId: userCredential.user!.uid);

      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'user_info': userModel.toMap()}, SetOptions(merge: true));
      final MyServices services = Get.find();
      await services.sharedPreferences
          .setString('user_info', jsonEncode(userModel.toMap()));
      return true;
    } on FirebaseException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'Auth Error', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> logIn({required UserModel userModel}) async {
    // firebaseAuth.signOut();
    // return;
    // printInfo(info: userModel.password.toString());
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.password!);
      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> reSendVerifyCode({required String email}) async {
    // firebaseAuth.currentUser!.sendEmailVerification();

    return await reSetPassword(email: email);
  }

  @override
  Future<bool> reSetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
    // firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<bool> setNewPassword(
      {required String code, required newPassword}) async {
    try {
      // firebaseAuth.confirmPasswordReset(code: code, newPassword: newPassword);
      // await Future.delayed(const Duration(seconds: 2));

      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> verifyCode({required String code}) async {
    try {
      // await firebaseAuth.verifyPasswordResetCode(code);
      await Future.delayed(const Duration(seconds: 2));

      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }
}
