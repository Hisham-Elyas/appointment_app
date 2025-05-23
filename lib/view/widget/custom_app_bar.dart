import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/functions/get_device_locale.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool goBack;
  final Color? backgroundColor;
  final bool? centerTitle;
  final void Function()? onTapTitle;

  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.goBack = true,
    this.backgroundColor,
    this.centerTitle = true,
    this.onTapTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: AppBar(
        centerTitle: centerTitle,
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottomOpacity: 0,
        shadowColor: Theme.of(context).colorScheme.surface.withOpacity(0.1),
        actions: actions,
        leading: goBack
            ? Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: IconButton(
                  alignment: Alignment.center,
                  enableFeedback: true,
                  onPressed: () => Get.back(),
                  icon: Icon(
                    getdeviceLocale(
                        en: Icons.arrow_back_ios_new, ar: Icons.arrow_back_ios),
                    color: Theme.of(context).textTheme.displaySmall!.color,
                  ),
                ),
              )
            : null,
        title: GestureDetector(
          onTap: onTapTitle,
          child: Text(
            title ?? '',
            style: TextStyle(
              fontSize: 24.sp,
              color: Theme.of(context).textTheme.displaySmall!.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 60.h);
}
