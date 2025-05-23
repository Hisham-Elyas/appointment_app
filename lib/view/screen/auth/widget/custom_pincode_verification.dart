import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../controller/forgot_password_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/string.dart';
import '../../../widget/custom_button.dart';

class CustomPinCodeVerification extends StatefulWidget {
  const CustomPinCodeVerification({
    Key? key,
    required this.pinCodelength,
  }) : super(key: key);
  final int pinCodelength;

  @override
  State<CustomPinCodeVerification> createState() =>
      _CustomPinCodeVerificationState();
}

class _CustomPinCodeVerificationState extends State<CustomPinCodeVerification> {
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  // snackBar(String? message) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message!),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResstPasswordController>(
      builder: (controller) => Column(
        children: <Widget>[
          PinCodeTextField(
            appContext: context,

            pastedTextStyle: const TextStyle(
              color: AppColor.mainColor,
              fontWeight: FontWeight.bold,
            ),
            length: widget.pinCodelength,

            animationType: AnimationType.fade,
            // validator: (v) {
            //   if (v!.length < 3) {
            //     return "I'm from validator";
            //   } else {
            //     return null;
            //   }
            // },
            pinTheme: PinTheme(
              activeColor: AppColor.mainColor,
              selectedColor: AppColor.mainColor,
              inactiveColor: Theme.of(context).colorScheme.surface,
              inactiveFillColor: const Color(0xffF9FAFB),
              selectedFillColor: Theme.of(context).colorScheme.surface,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(16.r),
              fieldHeight: 64.h,
              fieldWidth: 64.w,
              activeFillColor: Colors.white,
            ),
            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            errorAnimationController: errorController,
            // controller: textEditingController,
            keyboardType: TextInputType.number,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onCompleted: (v) {
              debugPrint("Completed");
            },
            // onTap: () {
            //   print("Pressed");
            // },
            onChanged: (value) {
              debugPrint(value);
              setState(() {
                currentText = value;
                controller.codeVerify = value;
              });
            },
            // beforeTextPaste: (text) {
            //   debugPrint("Allowing to paste $text");
            //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
            //   return true;
            // },
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasError ? "*Please fill up all the cells properly" : "",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          CustomButton(
            onPressed: () {
              // conditions for validating
              if (currentText.length != 4) {
                errorController!.add(ErrorAnimationType
                    .shake); // Triggering error shake animation
                setState(() => hasError = true);
              } else {
                setState(
                  () {
                    hasError = false;
                    // snackBar("OTP Verified!!");
                    controller.submitVerifyCode();
                  },
                );
              }
            },
            text: Verify.tr,
            width: 327.w,
            height: 56.h,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Didnt_receive_the_code.tr,
                style: TextStyle(color: AppColor.fontColor3, fontSize: 15.sp),
              ),
              TextButton(
                onPressed: () => controller.reSendVerifyCode(),
                child: Text(
                  Resend.tr,
                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
