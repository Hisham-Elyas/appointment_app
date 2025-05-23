import '../../../../core/class/handling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/order_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/string.dart';
import '../../../../data/model/order_model.dart';
import '../../../widget/custom_app_bar.dart';
import 'order_details_screen.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Orders.tr),
      body: GetBuilder<OrderController>(
        builder: (controller) => HandlingDataView(
          onPressedReload: () {
            controller.getAllOrders();
          },
          statusReq: controller.statusRequest,
          widget: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              children: [
                const CustomTapWidget(),
                SizedBox(height: 30.h),
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      controller.setTapLIstNum = value;
                    },
                    controller: controller.pagecontroller,
                    children: [
                      ///  Ongoing orders
                      ListView.separated(
                          itemCount: controller.ordersOngoing.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemBuilder: (context, index) => OrderWidget(
                                order: controller.ordersOngoing[index],
                                onTap: () {
                                  Get.to(() => OrderDetailsScreen(
                                      order: controller.ordersOngoing[index]));
                                },
                                onTapCancel: () {
                                  // controller.clearCartHistory();
                                  controller.cancelOrders(
                                      orderId:
                                          controller.ordersOngoing[index].id!);
                                },
                              )),

                      ////   History order
                      ListView.separated(
                          itemCount: controller.orderHistory.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemBuilder: (context, index) => OrderWidget(
                                order: controller.orderHistory[index],
                                onTap: () {
                                  Get.to(() => OrderDetailsScreen(
                                      order: controller.orderHistory[index]));
                                },
                              )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderWidget extends GetView<OrderController> {
  final void Function()? onTapCancel;
  final void Function()? onTap;

  final OrderModel order;
  const OrderWidget({
    Key? key,
    this.onTapCancel,
    this.onTap,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(12.r),
        splashColor: Theme.of(context).colorScheme.secondary,
        highlightColor: AppColor.mainColor3,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
          ),
          height: 130.h,
          width: 334.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: AppColor.mainColor,
                  ),
                  Text(
                    " ${order.listProduct.length}X  ${XProduct.tr}",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssetSVG.location2Icon,
                    height: 20.h,
                    width: 20.w,
                  ),
                  SizedBox(width: 5.w),
                  SizedBox(
                    width: 270.w,
                    child: Text(
                      order.userLocation.address,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 15.w),
                  Container(
                    height: 10.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      color: controller.statusColor(order.status!),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    order.status!.type.tr,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (order.status == Status.pending)
                    InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      splashColor: Theme.of(context).colorScheme.secondary,
                      highlightColor: AppColor.mainColor3,
                      onTap: onTapCancel,
                      child: Container(
                        alignment: Alignment.center,
                        width: 145.w,
                        height: 46.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.6),
                        ),
                        child: Text(Cancel.tr,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ));
  }
}

class CustomTapWidget extends GetView<OrderController> {
  const CustomTapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) => Container(
        width: 335.w,
        height: 46.h,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8.r)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.taps.length,
          itemBuilder: (context, index) => InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              controller.setTapLIstNum = index;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              alignment: Alignment.center,
              width: 335.w / controller.taps.length,
              height: 46.h,
              decoration: BoxDecoration(
                  color: index == controller.tapLIstNum
                      ? AppColor.mainColor
                      : null,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Text(controller.taps[index].tr,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: index == controller.tapLIstNum
                          ? AppColor.backgroundColor
                          : AppColor.fontColor1)),
            ),
          ),
        ),
      ),
    );
  }
}
