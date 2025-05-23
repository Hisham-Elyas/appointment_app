import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/drugs_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/string.dart';
import '../../../../data/model/drugs_model/product.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_search_bar.dart';
import 'drugs_detail_screen.dart';
import 'search_drugs_screen.dart';
import '../../../widget/product_widget.dart';

class DrugsScrren extends GetView<DrugsController> {
  const DrugsScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Pharmacy.tr, actions: [
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
              ImageAssetSVG.buyIconW,
              // ignore: deprecated_member_use
              color: AppColor.mainColor,
              fit: BoxFit.none,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
      ]),
      body: Column(children: [
        SizedBox(height: 33.h),
        //// search bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomSearchBar(
            text: Search_drugs_category.tr,
            onTap: () {
              showSearch(context: context, delegate: DrugsSearch());
            },
          ),
        ),

        SizedBox(height: 25.h),

        /// Popular Product  + see All  row
        Container(
          // margin: EdgeInsetsDirectional.only(start: 20.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Popular_Product.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontWeight: FontWeight.w500,
                  )),
              InkWell(
                borderRadius: BorderRadius.circular(15.r),
                onTap: () {
                  showSearch(context: context, delegate: DrugsSearch());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Text(
                    See_all.tr,
                    style: TextStyle(
                      color: AppColor.mainColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 28.h),

        GetBuilder<DrugsController>(builder: (drugsController) {
          final List<Product> drigsData = drugsController.randDrugsList;
          final List<Product> favoriteDrug =
              drugsController.favoriteDrug.values.toList();
          return HandlingDataView(
              statusReq: drugsController.statusReq,
              onPressedReload: drugsController.getAllDrougs,
              widget: Column(
                children: [
                  SizedBox(
                    height: 180.h,
                    child: ListView.separated(
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 15.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: drigsData.length,
                      itemBuilder: (context, index) => ProductWidget(
                        product: drigsData[index],
                        onTapAdd: () {
                          drugsController.addToCart(drigsData[index]);
                        },
                        onTap: () {
                          // drugsController.getalldata();
                          Get.to(
                            () => DrugsDetailScrren(product: drigsData[index]),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  // Spacer(),

                  /// fav Product  + see All  row
                  Container(
                    // margin: EdgeInsetsDirectional.only(start: 20.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Favorite_Product.tr,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w500,
                            )),
                        InkWell(
                          borderRadius: BorderRadius.circular(15.r),
                          onTap: () =>
                              Get.toNamed(AppRoutes.getFavoriteScreen()),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.h),
                            child: Text(
                              See_all.tr,
                              style: TextStyle(
                                color: AppColor.mainColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 28.h),
                  SizedBox(
                    height: 180.h,
                    child: favoriteDrug.isEmpty
                        ? Center(
                            child: Text(
                              'Add product to your favorite',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 20.w),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 15.w),
                            scrollDirection: Axis.horizontal,
                            itemCount: favoriteDrug.length,
                            itemBuilder: (context, index) => ProductWidget(
                              product: favoriteDrug[index],
                              onTapAdd: () {
                                drugsController.addToCart(favoriteDrug[index]);
                              },
                              onTap: () {
                                Get.to(
                                  () => DrugsDetailScrren(
                                      product: favoriteDrug[index]),
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ));
        }),
      ]),
    );
  }
}
