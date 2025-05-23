import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuer_city/core/functions/ckeck_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../core/class/enums.dart';
import '../core/class/local_notification.dart';
import '../core/constant/app_color.dart';
import '../core/constant/image_asset.dart';
import '../core/constant/string.dart';
import '../data/model/apointment_model.dart';
import '../data/model/doctor_model.dart';
import '../data/repositories/appointment_repo.dart';
import '../view/widget/custom_text_form_field.dart';
import 'notifications_controller.dart';
import 'user_controller.dart';

class ApointmentController extends GetxController {
  final AppointmentRepo appointmentRepo2;

  ApointmentController({
    required this.appointmentRepo2,
  });
  late StatusRequest statusReq;

  @override
  void onInit() {
    super.onInit();
    getAllAppointment();
  }

  void getAllAppointment() async {
    UserController userController = Get.find();

    if (!await ckeckInternet()) {
      statusReq = StatusRequest.serverFailure;
      update();
      return;
    }

    statusReq = StatusRequest.loading;
    update();

    FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: userController.userInf.userId!)
        .snapshots()
        .listen(
      (snapshot) {
        try {
          final appointments = snapshot.docs.map((doc) {
            final data = doc.data();
            return Appointment.fromMap({...data}, id: doc.id);
          }).toList();

          _appointmentlist
            ..clear()
            ..addAll(appointments);
          _appointmentlist.sort((a, b) => a.bookDate!.compareTo(b.bookDate!));

          statusReq = StatusRequest.success;
          update();
        } catch (e) {
          statusReq = StatusRequest.serverFailure;
          update();
        }
      },
      onError: (error) {
        statusReq = StatusRequest.serverFailure;
        update();
      },
    );
  }

  List<String> taps = [
    Upcoming,
    Completed,
    // Canceled,
  ];
  String? _userName;
  int tapLIstNum = 0;

  set setTapLIstNum(val) {
    tapLIstNum = val;
    update();
  }

  late DateTime bookDate;
  final GlobalKey<FormState> bookingformKey = GlobalKey();
  final List<Appointment> _appointmentlist = [];
  List<Appointment> get appointlist {
    _appointmentlist.sort(
      (a, b) => a.bookDate!.compareTo(b.bookDate!),
    );
    return _appointmentlist;
  }

  final AppointmentRepoImpHttp appointmentRepo = Get.find();

  set setuserName(val) => _userName = val;
  get getuserName => _userName;

  List<Appointment> filterAppointmentlist(int index) {
    List<Appointment> newlist = [];
    for (var el in _appointmentlist) {
      if (index == 0) {
        if (!el.isCompleted! &&
            el.bookDate!
                .isAfter(DateTime.now().add(const Duration(days: -1)))) {
          newlist.add(el);
        }
      } else if (index == 1) {
        if (el.isCompleted!) {
          newlist.add(el);
        }
      }
    }
    if (index == 2) {
      // newlist.addAll(getCacheCanceledAppoint());
    }

    return newlist;
  }

  String? userNamevalidator(String? val) {
    if (val!.isEmpty) {
      return Type_your_Name.tr;
    } else if (val.length < 3) {
      return Enter_your_vlied_name.tr;
    } else {
      setuserName = val;
      if (oldAppointment != null) {
        oldAppointment = oldAppointment!.copyWith(name: val);
      }
      return null;
    }
  }

  Appointment? oldAppointment;
  void bookApointment({
    required Doctor doctorinfo,
    required bool isNew,
  }) {
    showDatePicker(
      context: Get.context!,
      initialDate: isNew ? DateTime.now() : oldAppointment!.bookDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
      currentDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.mainColor, // Header background & OK/Cancel
              onPrimary: Colors.white, // Header text color
              onSurface: AppColor.fontColor1, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.mainColor, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((date) {
      if (date == null) {
        return;
      }
      bookDate = date;
      showBokingDialog(
        isNew: isNew,
        bookingDate: bookDate,
        doctorinfo: doctorinfo,
        oldAppoint: oldAppointment,
      );
    });
  }

  DateTime? remindDate;
  void showBokingDialog(
      {required DateTime bookingDate,
      required Doctor doctorinfo,
      Appointment? oldAppoint,
      required bool isNew}) {
    oldAppointment = oldAppoint;
    bookDate = bookingDate;
    Get.defaultDialog(
      title: Book_Appointment.tr,
      barrierDismissible: false,
      titlePadding: EdgeInsets.only(top: 20.h),
      contentPadding: EdgeInsets.all(20.h),
      buttonColor: AppColor.mainColor,
      radius: 30.r,
      titleStyle: TextStyle(
        color: Theme.of(Get.context!).textTheme.displayLarge!.color,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      content: BokingDialog(
        isNew: isNew,
        date: bookingDate,
        doctorinfo: doctorinfo,
      ),
    );
  }

  bool isAdding = false;
  Future<void> submitApointment({
    required Doctor doctorinfo,
    required bool isNew,
  }) async {
    if (!bookingformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    bookingformKey.currentState!.save();
    Get.focusScope!.unfocus();
    isAdding = true;
    update();
    final bool isSucss;
    final UserController userInfo = Get.find();
    final Appointment? newAppointment;
    if (isNew) {
      newAppointment = Appointment(
        userId: userInfo.userInf.userId!,
        bookDate: bookDate,
        doctor: doctorinfo,
        doctorId: doctorinfo.id!,
        name: _userName!,
        isCompleted: false,
        isConfirmed: false,

      );
      isSucss =
          await appointmentRepo.addAppointment(appointment: newAppointment);
    } else {
      // print("===========>  updated");

      newAppointment =
          oldAppointment!.copyWith(bookDate: bookDate, name: _userName!);
      isSucss =
          await appointmentRepo.updateAppointment(appointment: newAppointment);

      _userName = null;
    }

    if (isSucss) {
      getAllAppointment();
      NotificationController ntfc = Get.find();
      remindDate = ntfc.remindDate;
      if (remindDate != null) {
        bookDate.add(
            Duration(hours: remindDate!.hour, minutes: remindDate!.minute));
        LocalNotifications.showScheduleNotification(
            id: 2,
            context: Get.context!,
            title: "Schedule Appointment",
            body: "This is a Schedule Appointment Notification",
            payload: jsonEncode(newAppointment),
            time: bookDate);
        // LocalNotifications.showSimpleNotification(
        //   title: "Schedule Appointment",
        //   body: "This is a Schedule Appointment Notification",
        //   payload: jsonEncode(newAppointment),
        // );
      }
      isAdding = false;
      Get.close(1);
      update();
    } else {
      isAdding = false;
      update();
    }
  }

  bool isCanceling = false;

  void cancelApointment({required Appointment appointment}) async {
    log(_appointmentlist.length.toString());
    isCanceling = true;
    update();
    final bool isCanceled =
        await appointmentRepo.deleteAppointment(appointmentId: appointment.id);
    if (isCanceled) {
      // cacheCanceledAppoint(appointment: appointment);
      _appointmentlist.removeWhere((element) => element.id == appointment.id);
      // appointmentRepo.appointmentLocalData.cachegetAppointment(
      //     key: 'APPOINTMENT_CACHE',
      //     appointment: AppointmentModel(
      //         count: _appointmentlist.length, appointment: _appointmentlist));
      if (_appointmentlist.isEmpty) {
        statusReq = StatusRequest.noData;
      }
      isCanceling = false;
      update();
    } else {
      isCanceling = false;
      update();
    }
  }

  // void cacheCanceledAppoint({required Appointment appointment}) {
  //   List<Appointment> cancledAppoint = [];
  //   try {
  //     cancledAppoint = appointmentRepo.appointmentLocalData
  //         .getCachedAppointmentModel(
  //           key: 'APPOINTMENT_CACHE',
  //         )
  //         .appointment;
  //   } on EmptyCacheException catch (e) {
  //     log(e.toString());
  //   }
  //   cancledAppoint.add(appointment);
  //   appointmentRepo.appointmentLocalData.cachegetAppointment(
  //     appointment: AppointmentModel(
  //         count: cancledAppoint.length, appointment: cancledAppoint),
  //     key: 'APPOINTMENT_CACHE',
  //   );
  // }

  // List<Appointment> getCacheCanceledAppoint() {
  //   try {
  //     final cancledAppoint = appointmentRepo.appointmentLocalData
  //         .getCachedAppointmentModel(
  //           key: 'CANCELED_APPOINTMENT_CACHE',
  //         )
  //         .appointment;
  //     return cancledAppoint;
  //   } on EmptyCacheException {
  //     return [];
  //   }
  // }
}

class BokingDialog extends GetView<ApointmentController> {
  final DateTime date;
  final Doctor doctorinfo;
  final bool isNew;

  const BokingDialog({
    super.key,
    required this.isNew,
    required this.doctorinfo,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final NotificationController notification = Get.find();

    return SizedBox(
      width: double.maxFinite,
      child: Form(
        key: controller.bookingformKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              // autofocus: true,
              initialValue: isNew
                  ? controller.getuserName ?? ''
                  : controller.oldAppointment?.name ?? '',
              hintText: Enter_your_name.tr,
              prefixIconImg: ImageAssetPNG.userIcons,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              isvalid: true,
              validator: (val) => controller.userNamevalidator(val),
              onSaved: (val) => controller.setuserName = val,
            ),
            SizedBox(height: 15.h),
            Text(Date.tr,
                style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                )),
            Row(
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
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Get.back();
                    controller.bookApointment(
                      isNew: isNew,
                      doctorinfo: doctorinfo,
                    );
                  },
                  child: Text(Change.tr,
                      style: TextStyle(
                        color: AppColor.fontColor2,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            TextButton.icon(
              onPressed: () {
                notification.showBokingDialog(bookingDate: date);
              },
              icon: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: SvgPicture.asset(
                  ImageAssetSVG.notificationLogo,
                  height: 25.h,
                  width: 25.w,
                  // ignore: deprecated_member_use
                  color: AppColor.mainColor,
                ),
              ),
              label: Text(Remind_Me.tr,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            GetBuilder<ApointmentController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: controller.isAdding
                          ? null
                          : () {
                              controller.setuserName = null;
                              Get.close(1);
                            },
                      style: const ButtonStyle(
                          side: WidgetStatePropertyAll(
                              BorderSide(width: 2, color: AppColor.mainColor))),
                      child: Text(Cancel.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ))),
                  ElevatedButton(
                    style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll(5),
                        backgroundColor:
                            WidgetStatePropertyAll(AppColor.mainColor)),
                    onPressed: controller.isAdding
                        ? null
                        : () => controller.submitApointment(
                              doctorinfo: doctorinfo,
                              isNew: isNew,
                            ),
                    child: controller.isAdding
                        ? SizedBox(
                            height: 25.h,
                            width: 25.w,
                            child: CircularProgressIndicator(strokeWidth: 3.w),
                          )
                        : Text(
                            Confirm.tr,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
