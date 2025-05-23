import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constant/image_asset.dart';

showOverlay({required Future<void> Function() asyncFunction}) {
  Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 32.h),
          width: 327.w,
          height: 401.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: Theme.of(Get.context!).colorScheme.surface,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                ImageAssetSVG.logo2,
                height: 102.h,
                width: 102.w,
              ),
              // SizedBox(height: 32.h),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ));
}
