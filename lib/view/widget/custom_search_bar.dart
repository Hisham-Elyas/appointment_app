import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/image_asset.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const CustomSearchBar({
    Key? key,
    this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 324.w,
      height: 40,
      padding: EdgeInsetsDirectional.only(start: 17.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(width: 2.w, color: AppColor.mainColor3),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: onTap,
        child: Row(children: [
          SvgPicture.asset(
            ImageAssetSVG.searchLogo,
            // ignore: deprecated_member_use
            color: AppColor.mainColor,
          ),
          SizedBox(width: 12.h),
          Text(
            text,
            style: TextStyle(
                color: AppColor.fontColor4,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
