import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignInWith extends StatelessWidget {
  final String imgSvg;
  final String text;
  final void Function()? onTap;
  const SignInWith({
    super.key,
    required this.imgSvg,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(width: 1.w, color: const Color(0xffE5E7EB)),
      ),
      height: 56.h,
      width: 392.w,
      child: InkWell(
        borderRadius: BorderRadius.circular(25.r),
        onTap: onTap,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 18.w),
            SvgPicture.asset(
              imgSvg,
              height: 15.h,
              width: 15.w,
              fit: BoxFit.contain,
            ),

            SizedBox(width: 20.w),
            FittedBox(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Theme.of(context).textTheme.displayLarge!.color),
                ),
              ),
            ),
            // SizedBox(width: 89.w),
          ],
        ),
      ),
    );
  }
}
