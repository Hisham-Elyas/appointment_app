import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/drugs_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../drugs/drugs_detail_screen.dart';
import '../drugs/widget/cart_widget.dart';

class MyFavoriteScreen extends GetView<DrugsController> {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(title: My_Saved.tr, goBack: true, actions: [
          Container(
            padding: EdgeInsetsDirectional.only(end: 15.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () {
                controller.deleteAllFav();
              },
              child: Row(
                children: [
                  Text(
                    Clear.tr,
                    style: TextStyle(
                      color: AppColor.mainColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  SvgPicture.asset(
                    ImageAssetSVG.deleteIcon,
                    fit: BoxFit.none,
                  ),
                ],
              ),
            ),
          ),
        ]),
        body: Container(
          // width: 200,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 33.h),
          child: Column(children: [
            Expanded(
              child: GetBuilder<DrugsController>(
                // init: DrugsController(),
                builder: (controller) => controller.favoriteDrug.isEmpty
                    ? Center(child: Text(Add_product_to_your_favorite.tr))
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                        itemCount: controller.favoriteDrug.length,
                        itemBuilder: (context, index) {
                          final drigsData =
                              controller.favoriteDrug.values.toList();

                          return CartWidget(
                            onTap: () {
                              Get.to(
                                () => DrugsDetailScrren(
                                    product: drigsData[index]),
                              );
                            },
                            onTapIcon: () {
                              controller.addTofavorite(drigsData[index]);
                            },
                            drigs: drigsData[index],
                            buttomIcon: ImageAssetSVG.deleteIcon,
                          );
                        }),
              ),
            )
          ]),
        ));
  }
}
