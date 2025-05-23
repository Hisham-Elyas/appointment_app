import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/login_screen_controller.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/string.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: LOGIN.tr,
          goBack: controller.goBack(),
          // goBack: false,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 100.h),
              // width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GetBuilder<LoginScreenController>(
                      builder: (logincontroller) => Form(
                            key: logincontroller.loginFormKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  hintText: Enter_your_email.tr,
                                  prefixIconImg: ImageAssetPNG.emailIcons,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  isvalid: logincontroller.isvalidEmail,
                                  validator: (val) =>
                                      logincontroller.emailvalidator(val),
                                  onSaved: (val) =>
                                      logincontroller.setEmail = val,
                                ),
                                SizedBox(height: 16.h),
                                CustomTextFormField(
                                  hintText: Enter_your_password.tr,
                                  prefixIconImg: ImageAssetPNG.passwordIcons,
                                  suffixIconImg: logincontroller.isShowPass
                                      ? ImageAssetPNG.eyeSlashIcons
                                      : ImageAssetPNG.showpassIcons,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: logincontroller.isShowPass,
                                  isvalid: logincontroller.isvalidpassword,
                                  validator: (val) =>
                                      logincontroller.passwordvalidator(val),
                                  onSaved: (val) =>
                                      logincontroller.setPassword = val,
                                  onsuffixIconTap: () =>
                                      logincontroller.showPassword(),
                                ),
                              ],
                            ),
                          )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () =>
                            Get.toNamed(AppRoutes.getResetPasswordScreen()),
                        child: Text(
                          Forgot_Password.tr,
                        )),
                  ),
                  CustomButton(
                    text: LOGIN.tr,
                    width: 327.w,
                    height: 56.h,
                    onPressed: () {
                      controller.submit();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Dont_have_an_account.tr,
                        style: TextStyle(
                            color: AppColor.fontColor3, fontSize: 15.sp),
                      ),
                      TextButton(
                        onPressed: () =>
                            Get.offAllNamed(AppRoutes.getSignUpScreen()),
                        child: Text(
                          Sign_Up.tr,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
