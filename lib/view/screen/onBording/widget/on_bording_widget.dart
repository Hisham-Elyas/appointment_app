import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/string.dart';
import 'dots_controller_widget.dart';

class OnBordingWidet extends StatelessWidget {
  final String img;
  final String discription;
  final void Function()? onTapNext;
  final void Function()? onTapSkip;

  const OnBordingWidet({
    super.key,
    required this.img,
    required this.discription,
    required this.onTapNext,
    required this.onTapSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 27.w).copyWith(top: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15.r),
            onTap: onTapSkip,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Text(Skip.tr,
                  style: const TextStyle(color: AppColor.fontColor2)),
            ),
          ),
          Center(
            child: SizedBox(
              width: 321.w,
              height: 694.h,
              child: Stack(
                children: [
                  Image.asset(
                    img,
                    fit: BoxFit.contain,
                    width: 311.w,
                    height: 468.h,
                  ),
                  // SvgPicture.asset(
                  //   img,
                  //   width: 311.w,
                  //   height: 468.h,
                  // ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 321.w,
                      height: 226.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 40.h, horizontal: 17.w),
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.r)),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFFF5F7FF),
                              const Color(0xffF5F7FF).withOpacity(0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Column(
                        children: [
                          Text(
                            discription,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const DotsController(),
                                const Spacer(),
                                InkWell(
                                  onTap: onTapNext,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 0.h,
                                    ),
                                    height: 56.h,
                                    width: 56.w,
                                    decoration: BoxDecoration(
                                        color: AppColor.mainColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
