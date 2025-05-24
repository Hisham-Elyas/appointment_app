import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/app_color.dart';
import '../constant/image_asset.dart';
import 'enums.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusReq;
  final Widget widget;
  final double imgHeight;
  final String? buttonTextEmpty;
  final void Function()? onPressedTextButtom;
  final void Function()? onPressedReload;
  const HandlingDataView({
    super.key,
    required this.statusReq,
    required this.widget,
    this.onPressedTextButtom,
    this.onPressedReload,
    this.buttonTextEmpty,
    this.imgHeight = 400,
  });

  @override
  Widget build(BuildContext context) {
    if (statusReq == StatusRequest.loading) {
      return Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            ImageAssetSVG.loadingAmicorImg,
            fit: BoxFit.contain,
            height: imgHeight.h,
          ),
          Container(
              height: 40.r,
              width: 40.r,
              margin: EdgeInsets.only(top: 90.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(25.r)),
              child: SizedBox(
                  height: 15.r,
                  width: 15.r,
                  child: const CircularProgressIndicator(strokeWidth: 3)))
        ],
      );
    } else if (statusReq == StatusRequest.serverFailure) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssetSVG.noDataAmicorImg,
            fit: BoxFit.contain,
            height: imgHeight.h,
          ),
          Text('somethang go wrong',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.fontColor4)),
          SizedBox(height: 5.h),
          OutlinedButton(
              onPressed: onPressedReload, child: const Text('Reload'))
        ],
      );
    } else if (statusReq == StatusRequest.noData) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssetSVG.emptyBoxAmicorImg,
            fit: BoxFit.contain,
            height: imgHeight.h,
          ),
          OutlinedButton(
              onPressed: onPressedTextButtom, child: Text(buttonTextEmpty!))
        ],
      );
    } else {
      return widget;

      // Positioned(
      //   top: -150,
      //   left: 15,
      //   right: 15,
      //   child: Row(
      //     children: [
      //       Icon(
      //         Icons.wifi_off_rounded,
      //         size: 30,
      //         color: AppColor.fontColor5,
      //       ),
      //       SizedBox(width: 5.w),
      //       Text(
      //         'Offline Mode',
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //           color: AppColor.fontColor2,
      //         ),
      //       )
      //     ],
      //   ),
      // )
    }
  }
}
