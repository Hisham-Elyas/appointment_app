import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/drugs_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/string.dart';
import '../../../../core/functions/get_device_locale.dart';
import '../../../../data/model/drugs_model/product.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_button.dart';

class DrugsDetailScrren extends GetView<DrugsController> {
  final Product product;
  const DrugsDetailScrren({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Drugs_Detail.tr, actions: [
        Container(
          margin: EdgeInsetsDirectional.only(end: 20.w),
          height: 30.h,
          width: 30.w,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              Get.toNamed(AppRoutes.getDrugsCartScreen());
            },
            child: SvgPicture.asset(
              ImageAssetSVG.buyIcon,
              fit: BoxFit.none,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
      ]),
      body: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Image.asset(
            'assets/svg/Image.jpg',
            height: 250.h,
            fit: BoxFit.contain,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              width: 335.w,
              // height: 140.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getdeviceLocale(
                        en: product.drugInformationEn!.tradeName!,
                        ar: " ${product.drugInformationAr!.tradeName!}  -  ${product.drugInformationEn!.tradeName!}"),
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  DrugInfoWidget(
                      title: Strength.tr,
                      info: getdeviceLocale(
                          en: product.drugInformationEn!.strength ?? '',
                          ar: product.drugInformationAr!.strength ?? '')),
                  DrugInfoWidget(
                      title: Generic_Name.tr,
                      info: getdeviceLocale(
                          en: product.drugInformationEn!.genericName ?? '',
                          ar: product.drugInformationAr!.genericName ?? '')),
                  DrugInfoWidget(
                      title: Dosage_Form.tr,
                      info: getdeviceLocale(
                          en: product.drugInformationEn!.dosageForm ?? '',
                          ar: product.drugInformationAr!.dosageForm ?? '')),
                  DrugInfoWidget(
                      title: Route_of_Administration.tr,
                      info: getdeviceLocale(
                          en: product
                                  .drugInformationEn!.routeOfAdministration ??
                              '',
                          ar: product
                                  .drugInformationAr!.routeOfAdministration ??
                              '')),
                  DrugInfoWidget(
                      title: Pacakge_Size.tr,
                      info: getdeviceLocale(
                          en: product.drugInformationEn!.pacakgeSize ?? '',
                          ar: product.drugInformationAr!.pacakgeSize ?? '')),
                  DrugInfoWidget(
                      title: SFDA_Code.tr,
                      info: getdeviceLocale(
                          en: product.drugInformationEn!.sfdaCode ?? '',
                          ar: product.drugInformationAr!.sfdaCode ?? '')),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Row(
                          children: [
                            ElevatedButton.icon(
                                style: const ButtonStyle(
                                    elevation: WidgetStatePropertyAll(5)),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.format_list_bulleted_outlined,
                                ),
                                label: Text(
                                  Medical_bulletin.tr,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color),
                                ))
                          ],
                        ),
                      ),
                      Text(
                        '\$9 - \$12',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .color),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Theme.of(context).colorScheme.secondary),
              child: SvgPicture.asset(
                ImageAssetSVG.searchLogo,
                // ignore: deprecated_member_use
                color: AppColor.mainColor,
                fit: BoxFit.none,
                height: 24.h,
                width: 24.w,
              ),
            ),
            GetBuilder<DrugsController>(
              builder: (controller) => Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Theme.of(context).colorScheme.secondary),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () {
                    controller.addTofavorite(product);
                  },
                  child: SvgPicture.asset(
                    controller.isFavorite(product)
                        ? ImageAssetSVG.heartIcon
                        : ImageAssetSVG.heartWIcon,
                    fit: BoxFit.scaleDown,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                controller.addToCart(product);
              },
              text: Add_to_cart.tr,
              height: 50.h,
              width: 200.w,
            ),
          ],
        ),
      ),
    );
  }
}

class DrugInfoWidget extends StatelessWidget {
  final String title;
  final String info;
  const DrugInfoWidget({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title : ',
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).textTheme.displayLarge!.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            info,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColor.fontColor3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
