import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/appointment_controller.dart';
import '../../../controller/chats_controller.dart';
import '../../../controller/doctor_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../core/constant/image_asset.dart';
import '../../../data/repositories/appointment_repo.dart';
import 'Schedule/schedule_screen.dart';
import 'chats/message_history_screen.dart';
import 'home_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final page = [
    const HomeScreen(),
    const MessageHistoryScreen(),
    const ScheduleScreen(),
    const ProfileScreen()
  ];

  int indexpage = 0;

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    Get.put(DoctorController());
    Get.put(ApointmentController(
        appointmentRepo2: Get.find<AppointmentRepoImpHttp>()));
    Get.put(ChatsController());
    // Get.put(NotificationController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: page[indexpage],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: indexpage,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            setState(() {
              indexpage = value;
            });
            // print(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                indexpage == 0
                    ? ImageAssetSVG.homeIcon
                    : ImageAssetSVG.homeWIcon,
                fit: BoxFit.scaleDown,
                height: 24.h,
                width: 24.w,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                indexpage == 1
                    ? ImageAssetSVG.messageIcon
                    : ImageAssetSVG.messageWIcon,
                fit: BoxFit.scaleDown,
                height: 24.h,
                width: 24.w,
              ),
              label: 'message',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                indexpage == 2
                    ? ImageAssetSVG.calendarIcon
                    : ImageAssetSVG.calendarWIcon,
                fit: BoxFit.scaleDown,
                height: 24.h,
                width: 24.w,
              ),
              label: 'calendar',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                indexpage == 3
                    ? ImageAssetSVG.profileIcon
                    : ImageAssetSVG.profileWIcon,
                fit: BoxFit.scaleDown,
                height: 24.h,
                width: 24.w,
              ),
              label: 'profile',
            ),
          ]),
    );
  }
}
