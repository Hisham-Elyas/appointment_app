import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/app_color.dart';
import '../../../../../core/constant/image_asset.dart';
import '../../../../../core/functions/get_device_locale.dart';
import '../../../../../data/model/drugs_model/product.dart';

class CartWidget extends StatelessWidget {
  final Product drigs;
  final void Function()? onTap;
  final void Function()? onTapIcon;
  final String buttomIcon;
  const CartWidget({
    Key? key,
    required this.drigs,
    this.onTap,
    this.onTapIcon,
    this.buttomIcon = ImageAssetSVG.deleteIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      splashColor: Theme.of(context).colorScheme.secondary,
      highlightColor: AppColor.mainColor3,
      onTap: onTap,
      child: Container(
        height: 121.h,
        width: 334.w,
        padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 12.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xffE8F3F1),
              width: 1.5,
            )),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(
            'assets/svg/Image.jpg',
            fit: BoxFit.contain,
            width: 100.w,
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 160.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160.w,
                  child: Text(
                    getdeviceLocale(
                        en: drigs.drugInformationEn!.tradeName ?? '',
                        ar: drigs.drugInformationAr!.tradeName ?? ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  getdeviceLocale(
                      en: drigs.drugInformationEn!.genericName ?? '',
                      ar: drigs.drugInformationAr!.genericName ?? ''),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.fontColor3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  getdeviceLocale(
                      en: drigs.drugInformationEn!.strength ?? '',
                      ar: drigs.drugInformationAr!.strength ?? ''),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.fontColor3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(right: 10.w, top: 5.h),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: onTapIcon,
                  child: SvgPicture.asset(
                    buttomIcon,
                    // fit: BoxFit.none,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  '\$${Random().nextInt(25) + 10 * 2}',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.displayLarge!.color),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
