import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../core/class/local_notification.dart';
import '../core/class/time_picker_spinner.dart';
import '../core/constant/app_color.dart';
import '../core/constant/image_asset.dart';
import '../core/constant/routes.dart';
import '../core/constant/string.dart';
import '../core/error/exception.dart';
import '../core/services/services.dart';
import '../data/dataSoureces/localDataSource/appointment_localdata.dart';
import '../data/model/apointment_model.dart';

class NotificationController extends GetxController {
  final List<Appointment> notificationList = [];
  DateTime? remindDate;
  final MyServices myServices = Get.find();
  final AppointmentLocalDataImp appointmentLocalData = Get.find();

  listenToNotifications() {
    log("Listening to notification....");

    LocalNotifications.onClickNotification.stream.listen((event) async {
      log(event);
      addNotification(notification: event);

      Get.toNamed(AppRoutes.getNotificationsScreen());
    });
  }

  @override
  void onInit() {
    super.onInit();
    listenToNotifications();

    try {
      final AppointmentModel cach =
          appointmentLocalData.getCachedAppointmentModel(key: "notification");
      notificationList.addAll(cach.appointment);
    } on EmptyCacheException catch (e) {
      log(e.toString());
    }
  }

  void addNotification({required String notification}) {
    final newNotification = Appointment.fromJson(jsonDecode(notification));
    notificationList.add(newNotification);
    appointmentLocalData.cachegetAppointment(
        key: "notification",
        appointment: AppointmentModel(
            count: notificationList.length, appointment: notificationList));
  }

  void showBokingDialog({required DateTime bookingDate}) {
    Get.defaultDialog(
      title: 'Remind Me',
      barrierDismissible: false,
      titlePadding: EdgeInsets.only(top: 20.h),
      contentPadding: EdgeInsets.all(20.h),
      buttonColor: AppColor.mainColor,
      radius: 30.r,
      titleStyle: TextStyle(
        color: AppColor.fontColor3,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      content: SetNotificationDialog(
        date: bookingDate,
      ),
    );
  }
}

class SetNotificationDialog extends GetView<NotificationController> {
  final DateTime date;

  const SetNotificationDialog({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Date.tr,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge!.color,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              )),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                ImageAssetSVG.circleCalendarIcon,
                height: 40.h,
                width: 40.w,
              ),
              SizedBox(width: 10.w),
              Text(
                  Jiffy.parseFromDateTime(date)
                      .format(pattern: 'E, d MMM yyyy'),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  )),
              const Spacer(),
            ],
          ),
          TimePickerSpinner(
            is24HourMode: false,
            isForce2Digits: true,
            onTimeChange: (time) {
              controller.remindDate = time;
            },
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Get.close(1);
                  },
                  style: const ButtonStyle(
                      side: WidgetStatePropertyAll(
                          BorderSide(width: 2, color: AppColor.mainColor))),
                  child: Text(Cancel.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ))),
              ElevatedButton(
                onPressed: () {
                  Get.close(1);
                },
                child: Text(
                  Confirm.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
