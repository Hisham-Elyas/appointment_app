import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../controller/notifications_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/string.dart';
import '../../../../data/model/apointment_model.dart';
import '../../../widget/custom_app_bar.dart';

class NotificationsScreen extends GetView<NotificationController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: Notifications.tr),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.h, vertical: 12.0.w),
            child: ListView.separated(
                itemCount: controller.notificationList.length,
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) => NotificationWidget(
                      appointment: controller.notificationList[index],
                    ))));
  }
}

class NotificationWidget extends GetView<NotificationController> {
  final Appointment appointment;

  const NotificationWidget({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 197.h,
      width: 335.w,
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1.5.w, color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${You_Have_Appointment_With.tr} ${appointment.doctor.name ?? ''}',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge!.color)),
          SizedBox(height: 5.h),
          Text(appointment.doctor.specialty ?? '',
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.fontColor2)),
          SizedBox(height: 10.h),
          Row(
            children: [
              SvgPicture.asset(
                ImageAssetSVG.circleCalendarIcon,
                height: 30.h,
                width: 30.w,
              ),
              SizedBox(width: 10.w),
              Text(
                  Jiffy.parseFromDateTime(appointment.bookDate!)
                      .format(pattern: 'E, d MMM yyyy'),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
