import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/string.dart';
import '../../widget/custom_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          width: double.maxFinite,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   ImageAssetPNG.logo2,
                //   // width: 96.w,
                //   // height: 98.52.h,
                //   // fit: BoxFit.fill,
                // ),
                SvgPicture.asset(
                  ImageAssetSVG.logo2,
                  width: 96.w,
                  height: 98.52.h,
                  // fit: BoxFit.cover,
                ),
                SizedBox(height: 40.48.h),
                Text(Lets_get_started.tr,
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).textTheme.displayLarge!.color)),
                SizedBox(height: 9.h),
                Text(
                    Login_to_enjoy_the_features_weve_provided_and_stay_healthy
                        .tr,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: AppColor.fontColor2, fontSize: 16.sp)),
                SizedBox(height: 60.h),
                CustomButton(
                  width: 263.w,
                  height: 56.h,
                  text: LOGIN.tr,
                  onPressed: () => Get.toNamed(AppRoutes.getLoginScreen()),
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  width: 263.w,
                  height: 56.h,
                  isOutlin: true,
                  text: Sign_Up.tr,
                  onPressed: () => Get.toNamed(AppRoutes.getSignUpScreen()),
                ),
              ]),
        ),
      ),
    );
  }
}
