import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/app_color.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final bool isOutlin;
  final double? height;
  final double? width;
  final String? text;
  final double? borderRadius;
  const CustomButton({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.isOutlin = false,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(isOutlin
              ? AppColor.mainColor.withOpacity(0.4)
              : AppColor.mainColor3.withOpacity(0.6)),
          backgroundColor: WidgetStatePropertyAll(isOutlin
              ? Theme.of(context).colorScheme.surface
              : AppColor.mainColor),
          elevation: WidgetStatePropertyAll(isOutlin ? 1 : 5),
          enableFeedback: true,
          padding: const WidgetStatePropertyAll(EdgeInsets.all(0))),
      onPressed: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          //     color: isOutlin ? Theme.of(context).colorScheme.background : AppColor.mainColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 32.r),
          border:
              isOutlin ? Border.all(width: 2, color: AppColor.mainColor) : null,
        ),
        child: Center(
            child: text == null
                ? child
                : Text(
                    text!,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isOutlin
                            ? AppColor.mainColor
                            : Theme.of(context).colorScheme.surface),
                  )),
      ),
    );
  }
}
