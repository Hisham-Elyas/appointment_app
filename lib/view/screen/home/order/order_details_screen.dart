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

class OrderDetailsScreen extends GetView<OrderController> {
  final OrderModel order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: Orders_Details.tr),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(11.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border:
                        Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
                  ),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              color: AppColor.mainColor,
                            ),
                            Text(
                              " ${order.listProduct.length}X ${XProduct.tr}",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ...List.generate(
                          order.listProduct.length,
                          (index) => Text(
                            "${index + 1}. ${order.listProduct[index]}",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              ImageAssetSVG.location2Icon,
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              children: [
                                SizedBox(
                                  width: 270.w,
                                  child: Text(
                                    order.userLocation.address,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(children: [
                          SizedBox(width: 15.w),
                          Container(
                            height: 8.h,
                            width: 8.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: controller.statusColor(order.status!),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            order.status!.type.tr,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          if (order.status == Status.pending)
                            InkWell(
                              borderRadius: BorderRadius.circular(12.r),
                              splashColor:
                                  Theme.of(context).colorScheme.secondary,
                              highlightColor: AppColor.mainColor3,
                              onTap: () async {
                                await controller.cancelOrders(
                                    orderId: order.id!);
                                Get.close(1);
                              },
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
                        ])
                      ]),
                ),
              )),
        ));
  }
}
