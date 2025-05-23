import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/forgot_password_controller.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/string.dart';
import '../../widget/custom_app_bar.dart';
import 'widget/custom_pincode_verification.dart';

class VerifyCodeScreen extends GetView<ResstPasswordController> {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h).copyWith(top: 34.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(Enter_Verification_Code.tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 26.sp,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontWeight: FontWeight.bold)),
            Text(
                '${'${Enter_code_that_we_have_sent_to_your_email.tr} ${controller.email}'}  ',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColor.fontColor2,
                )),
            SizedBox(height: 32.h),
            const CustomPinCodeVerification(pinCodelength: 4),
          ]),
        ),
      ),
    );
  }
}
