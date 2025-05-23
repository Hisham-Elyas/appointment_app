import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/settings_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/string.dart';
import '../../../widget/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Settings.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: GetBuilder<SettingsController>(builder: (controller) {
          return Column(children: [
            CustomListTileWidget(
              icon: Icons.location_on_rounded,
              title: Address.tr,
              onTap: () {
                Get.toNamed(AppRoutes.getAddressListScreen());
              },
            ),
            SizedBox(height: 10.h),
            CustomListTileWidget(
              icon: Icons.language_rounded,
              title: Language.tr,
              onTap: () {
                controller.switchLang();
              },
            ),
            SizedBox(height: 10.h),
            CustomListTileWidget(
              icon: Icons.brightness_medium,
              title: Dark_Mode.tr,
              trailing: Switch(
                value: controller.isDarkMode,
                onChanged: (value) {
                  controller.switchDarkMode(value: value);
                },
              ),
            ),
            SizedBox(height: 10.h),
            CustomListTileWidget(
              icon: Icons.feedback,
              title: Report_a_Problem_Or_Leave_Feedback.tr,
              onTap: () {
                controller.showFeedback();
              },
            ),
          ]);
        }),
      ),
    );
  }
}

class CustomListTileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData icon;
  final Widget? trailing;

  const CustomListTileWidget({
    Key? key,
    this.onTap,
    required this.title,
    required this.icon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 10,
        child: ListTile(
          trailing: trailing,
          onTap: onTap,
          leading: Icon(
            icon,
            color: AppColor.mainColor,
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge!.color),
          ),
        ));
  }
}
