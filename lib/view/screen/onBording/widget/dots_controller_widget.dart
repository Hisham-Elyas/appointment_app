import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/onbording_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/static_data.dart';

class DotsController extends StatelessWidget {
  const DotsController({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBordingController>(
      builder: (controller) => Row(
        children: List.generate(
          onBoardingList.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 12.63.w,
            height: 4.h,
            decoration: BoxDecoration(
                color: controller.currentPage == index
                    ? AppColor.mainColor
                    : AppColor.mainColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25)),
          ),
        ),
      ),
    );
  }
}
