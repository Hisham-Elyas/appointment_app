import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/user_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/string.dart';
import '../Schedule/schedule_screen.dart';

class ProfileScreen extends GetView<UserController> {
  const ProfileScreen({super.key});

  getColor() {
    if (Get.isDarkMode) {
      return [
        const Color(0xff52D1C6).withAlpha(150),
        const Color(0xff52D1C6).withAlpha(150),
      ];
    } else {
      return [
        const Color(0xff52D1C6),
        const Color(0xff30ADA2),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) => HandlingDataView(
        statusReq: controller.statusRequest,
        onPressedReload: () async {
          await controller.getUserInfo();
        },
        widget: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: getColor(),
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )),
          child: Column(children: [
            SizedBox(
              height: 250.h,
              width: MediaQuery.of(context).size.width,
              // color: AppColor.mainColor3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: SvgPicture.asset(
                      ImageAssetSVG.logo2,
                      fit: BoxFit.scaleDown,
                      height: 60.h,
                      width: 60.w,
                    ),
                  ),
                  SizedBox(height: 19.h),
                  Text(
                    controller.userInf.userName!,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                  Text(
                    controller.userInf.email,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w)
                    .copyWith(top: 31.h, bottom: 60.h),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.r)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CustomProfileButton(
                        title: Appointmnet.tr,
                        imageAssetSVG: ImageAssetSVG.documentIcon,
                        onTap: () {
                          Get.to(() => const ScheduleScreen(goBack: true));
                        },
                      ),
                      CustomProfileButton(
                        title: FAQs.tr,
                        imageAssetSVG: ImageAssetSVG.chatIcon,
                        onTap: () {
                          Get.toNamed(AppRoutes.getFeedbackScreen());
                        },
                      ),
                      CustomProfileButton(
                        title: Settings.tr,
                        imageAssetSVG: ImageAssetSVG.settingsIcon,
                        onTap: () {
                          Get.toNamed(AppRoutes.getSettingsScreen());
                        },
                      ),
                      CustomProfileButton(
                        title: Logout.tr,
                        colorTitle: AppColor.fontColor5,
                        isLast: true,
                        imageAssetSVG: ImageAssetSVG.dangerCircleIcon,
                        onTap: () {
                          controller.logeOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class CustomProfileButton extends StatelessWidget {
  final String title;
  final String imageAssetSVG;
  final void Function()? onTap;
  final Color? colorTitle;
  final bool isLast;
  const CustomProfileButton({
    super.key,
    required this.title,
    required this.imageAssetSVG,
    this.onTap,
    this.colorTitle,
    // this.colorTitle = Theme.of(context).textTheme.displayLarge!.color,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 63.h,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: SvgPicture.asset(
                    imageAssetSVG,
                    fit: BoxFit.contain,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: colorTitle ??
                          Theme.of(context).textTheme.displayLarge!.color),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
        isLast
            ? const SizedBox()
            : Divider(
                endIndent: 10.w,
                indent: 10.w,
                color: Theme.of(context).colorScheme.secondary,
              )
      ],
    );
  }
}
