import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/forgot_password_controller.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/string.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';

class ResetPasswordScreen extends GetView<ResstPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h).copyWith(top: 34.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(Forgot_Your_Password.tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 26.sp,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontWeight: FontWeight.bold)),
          Text(
              Enter_your_email_or_your_phone_number_we_will_send_you_confirmation_code
                  .tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.fontColor2,
              )),
          SizedBox(height: 34.h),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 1.w, color: const Color(0xffE5E7EB)),
                  borderRadius: BorderRadius.circular(24.r),
                  color: const Color(0xffF9FAFB),
                ),
                height: 56.h,
                width: 327.w,
              ),
              Positioned(
                top: 4.w,
                left: 4.w,
                bottom: 4.h,
                child: Container(
                  width: 151.w,
                  height: 43.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29.r),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Center(
                      child: Text(
                    EMAIL.tr,
                    style: const TextStyle(color: AppColor.mainColor),
                  )),
                ),
              ),
              Positioned(
                top: 4.w,
                bottom: 4.h,
                right: 4.w,
                child: Container(
                  width: 151.w,
                  height: 43.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29.r),
                  ),
                  child: Center(
                      child: Text(
                    Phone.tr,
                    style: const TextStyle(color: AppColor.fontColor2),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(height: 34.h),
          Form(
            key: controller.formKeyEmail,
            child: CustomTextFormField(
              hintText: Enter_your_email.tr,
              prefixIconImg: ImageAssetPNG.emailIcons,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              isvalid: true,
              validator: (val) => controller.emailvalidator(val),
              onSaved: (val) => controller.setEmail = val,
            ),
          ),
          SizedBox(height: 34.h),
          CustomButton(
            text: Reset_Password.tr,
            width: 327.w,
            height: 56.h,
            onPressed: () {
              controller.reSetPassword();
            },
          )
        ]),
      ),
    );
  }
}
