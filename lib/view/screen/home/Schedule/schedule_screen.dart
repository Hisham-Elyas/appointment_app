import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../controller/appointment_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/string.dart';
import '../../../../data/model/apointment_model.dart';
import '../../../widget/custom_app_bar.dart';

class ScheduleScreen extends GetView<ApointmentController> {
  final bool goBack;
  const ScheduleScreen({
    super.key,
    this.goBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Schedule.tr,
        centerTitle: false,
        goBack: goBack,
        // actions: [
        //   Padding(
        //     padding: EdgeInsetsDirectional.only(end: 20.w),
        //     child: InkWell(
        //         borderRadius: BorderRadius.circular(24.r),
        //         onTap: () {
        //           Get.toNamed(AppRoutes.getNotificationsScreen());
        //         },
        //         child: SvgPicture.asset(
        //           ImageAssetSVG.notificationLogo,
        //           // ignore: deprecated_member_use
        //           color: AppColor.mainColor,
        //         )),
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(children: [
          const CustomTapWidget(),
          SizedBox(height: 30.h),
          GetBuilder<ApointmentController>(builder: (controller) {
            final data =
                controller.filterAppointmentlist(controller.tapLIstNum);
            return HandlingDataView(
              buttonTextEmpty: Add_Appointment.tr,
              statusReq: controller.statusReq,
              onPressedTextButtom: () {},
              onPressedReload: () => controller.getAllAppointment(),
              widget: Expanded(
                child: ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                    itemBuilder: (context, index) => ScheduleWidget(
                          appointment: data[index],
                          onTapCancel: controller.isCanceling
                              ? null
                              : () {
                                  controller.cancelApointment(
                                      appointment: data[index]);
                                },
                          onTapReschedule: () {
                            controller.showBokingDialog(
                              isNew: false,
                              oldAppoint: data[index],
                              bookingDate: data[index].bookDate!,
                              doctorinfo: data[index].doctor,
                            );
                          },
                        )),
              ),
            );
          })
        ]),
      ),
    );
  }
}

class CustomTapWidget extends StatelessWidget {
  const CustomTapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApointmentController>(
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
                      ? Theme.of(context).colorScheme.primary
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

class ScheduleWidget extends GetView<ApointmentController> {
  final Appointment appointment;
  final void Function()? onTapReschedule;
  final void Function()? onTapCancel;

  const ScheduleWidget({
    Key? key,
    required this.onTapReschedule,
    required this.onTapCancel,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 197.h,
      width: 335.w,
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1.5.w, color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dr. ${appointment.doctor.name}',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color)),
                  Text(appointment.doctor.specialty!,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.fontColor2))
                ],
              ),
              CircleAvatar(
                radius: 30.r,
                backgroundImage: const AssetImage(
                    'assets/images/pexels-cedric-fauntleroy-4270371.png'),
              )
            ],
          ), // Chardiologist
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                ImageAssetSVG.circleCalendarIcon,
                height: 30.h,
                width: 30.w,
              ),
              SizedBox(width: 15.w),
              Text(
                  Jiffy.parseFromDateTime(appointment.bookDate!)
                      .format(pattern: 'E, d/M/yyyy'),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(width: 50.w),
              Container(
                height: 8.h,
                width: 8.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: appointment.isConfirmed!
                      ? const Color(0xff7beb78)
                      : Colors.grey,
                ),
              ),
              SizedBox(width: 5.w),
              Text(appointment.isConfirmed! ? Confirmed.tr : Pending.tr,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          SizedBox(height: 15.h),
          if (controller.tapLIstNum != 2 &&
              !appointment.isCompleted! &&
              appointment.bookDate!
                  .isAfter(DateTime.now().add(const Duration(days: -1))))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  splashColor: AppColor.mainColor,
                  highlightColor: AppColor.mainColor,
                  onTap: onTapReschedule,
                  child: Container(
                    alignment: Alignment.center,
                    width: 145.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColor.mainColor.withOpacity(0.8)),
                    child: Text(Reschedule.tr,
                        style: TextStyle(
                          color: AppColor.backgroundColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
