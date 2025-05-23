import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/image_asset.dart';
import '../../core/functions/get_device_locale.dart';
import '../../data/model/drugs_model/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  final void Function()? onTap;
  final void Function()? onTapAdd;
  const ProductWidget({
    super.key,
    required this.onTap,
    required this.onTapAdd,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        width: 122.w,
        height: 180.h,
        // color: Colors.red,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            // color: Color(0xffE8F3F1),
            border: Border.all(
              color: AppColor.mainColor2,
              width: 1.5,
            )),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                  child: Image.asset(
                'assets/svg/Image.jpg',
                // product.images??'',
                fit: BoxFit.cover,
              )),
              // SvgPicture.asset('assets/svg/Image2.jpg'),

              Text(
                getdeviceLocale(
                    en: product.drugInformationEn!.tradeName ?? '',
                    ar: product.drugInformationAr!.tradeName ?? ''),
                maxLines: 1,
                style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                getdeviceLocale(
                    en: product.drugInformationEn!.strength ?? '',
                    ar: product.drugInformationAr!.strength ?? ''),
                maxLines: 1,
                style: TextStyle(
                    color: AppColor.fontColor4,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ),
              FittedBox(
                child: Row(
                  children: [
                    Text(
                      'Size ',
                      style: TextStyle(
                          color: AppColor.fontColor4,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      getdeviceLocale(
                          en: product.drugInformationEn!.pacakgeSize ?? '',
                          ar: product.drugInformationAr!.pacakgeSize ?? ''),
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColor.fontColor4,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      '\$',
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(5.r),
                    onTap: onTapAdd,
                    child: SvgPicture.asset(
                      ImageAssetSVG.addIcon,
                      fit: BoxFit.none,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
