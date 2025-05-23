import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/drugs_controller.dart';
import '../../../../core/constant/app_color.dart';

import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_button.dart';
import 'drugs_detail_screen.dart';
import 'widget/cart_widget.dart';

class CartScreen extends GetView<DrugsController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: CustomAppBar(title: My_Cart.tr, actions: [
        Container(
          padding: EdgeInsetsDirectional.only(end: 20.h),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              controller.deleteAllCart();
            },
            child: Row(
              children: [
                Text(
                  Clear.tr,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: AppColor.mainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 5.w),
                SvgPicture.asset(
                  ImageAssetSVG.deleteIcon,
                  fit: BoxFit.none,
                  // ignore: deprecated_member_use
                  color: AppColor.mainColor,
                ),
              ],
            ),
          ),
        ),
      ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: GetBuilder<DrugsController>(
              builder: (controller) => controller.cartDrigs.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          ImageAssetPNG.emptyBoxImg,
                          fit: BoxFit.contain,
                          height: 200.h,
                          width: 200.w,
                        ),
                        SizedBox(height: 15.h),
                        Text(Your_cart_is_Empty.tr,
                            style: TextStyle(
                              color: AppColor.fontColor3,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(height: 100.h),
                      ],
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemCount: controller.cartDrigs.length,
                      itemBuilder: (context, index) {
                        final drigsData = controller.cartDrigs;
                        return CartWidget(
                          onTapIcon: () {
                            controller.deleteFromCart(drigsData[index]);
                          },
                          onTap: () {
                            // Get.focusScope!.unfocus();

                            Get.to(() =>
                                DrugsDetailScrren(product: drigsData[index]));
                          },
                          drigs: drigsData[index],
                        );
                      }),
            ),
          )
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Total.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.fontColor3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$ - . -',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.displayLarge!.color),
                ),
              ],
            ),
            CustomButton(
              onPressed: () {
                controller.checkout();
              },
              text: Checkout.tr,
              height: 50.h,
              // width: 192.w,
              width: 200.w,
            ),
          ],
        ),
      ),
    );
  }
}
