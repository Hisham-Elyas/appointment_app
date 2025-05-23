// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../controller/hospitals_controller.dart';
import '../../../../core/class/enums.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../data/model/hospital_model.dart';
import '../../../widget/custom_app_bar.dart';

class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Hospitals", actions: [
        // Container(
        //   margin: EdgeInsetsDirectional.only(end: 20.w),
        //   height: 30.h,
        //   width: 30.w,
        //   child: InkWell(
        //     borderRadius: BorderRadius.circular(8.r),
        //     onTap: () {},
        //     child: SvgPicture.asset(
        //       ImageAssetSVG.searchLogo,
        //       fit: BoxFit.none,
        //       // ignore: deprecated_member_use
        //       color: AppColor.mainColor,
        //       height: 30.h,
        //       width: 30.w,
        //     ),
        //   ),
        // ),
      ]),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 20.h),
          child: GetBuilder<HospitalsController>(
            builder: (controller) => HandlingDataView(
                onPressedReload: () {
                  controller.getAllHospital();
                },
                statusReq: controller.statusReq,
                widget: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 13.h),
                  itemCount: controller.hospitalList.length,
                  itemBuilder: (context, index) => HospitalWidget(
                    hospitalModel: controller.hospitalList[index],
                    onTap: () {},
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class HospitalWidget extends GetView<HospitalsController> {
  final void Function() onTap;
  final HospitalModel hospitalModel;
  const HospitalWidget({
    Key? key,
    required this.onTap,
    required this.hospitalModel,
  }) : super(key: key);

  @override
  // This widget is responsible for rendering a hospital widget in the hospital
  // screen. It displays the hospital's name, rating, address, and allows the
  // user to call the hospital's phone number.
  Widget build(BuildContext context) {
    return InkWell(
      // Set the border radius of the widget to make it round.
      borderRadius: BorderRadius.circular(12.r),
      // Set the splash color to the secondary color of the theme.
      splashColor: Theme.of(context).colorScheme.secondary,
      // Set the highlight color to the main color of the theme.
      highlightColor: AppColor.mainColor3,
      // Define what happens when the user taps on the widget.
      onTap: onTap,
      // The main container that holds all the widget's content.
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
        decoration: BoxDecoration(
          // Set the border radius of the container to make it round.
          borderRadius: BorderRadius.circular(11.r),
          // Add a border to the container.
          border: Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
        ),
        height: 130.h,
        width: 334.w,
        child: Row(
          // Align the children in the row to the start.
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // The container that holds the hospital's logo.
            Container(
              height: 111.h,
              width: 111.w,
              decoration: BoxDecoration(
                // Set the border radius of the container to make it round.
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ClipRRect(
                // Set the border radius of the clip rect to make it round.
                borderRadius: BorderRadius.circular(8.r),
                // Load the hospital's logo as a SVG asset.
                child: SvgPicture.asset(ImageAssetSVG.hospitalLogo),
              ),
            ),
            SizedBox(width: 18.w),
            // The column that holds the hospital's name and rating.
            Column(
              // Align the children in the column to the start.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The text widget that displays the hospital's name.
                Text(
                  hospitalModel.name,
                  style: TextStyle(
                      // Set the color of the text to the body large color of the theme.
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                // The container that holds the hospital's rating.
                Container(
                  height: 18.h,
                  width: 41.w,
                  decoration: BoxDecoration(
                    // Set the border radius of the container to make it round.
                    borderRadius: BorderRadius.circular(3.r),
                    // Set the background color of the container to the secondary color of the theme.
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Row(
                    // Align the children in the row evenly.
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Load the star icon as a SVG asset.
                      SvgPicture.asset(
                        ImageAssetSVG.starIcon,
                        fit: BoxFit.none,
                        height: 13.h,
                        width: 13.w,
                      ),
                      // The text widget that displays the hospital's rating.
                      Text(
                        '4,7',
                        style: TextStyle(
                            color: AppColor.mainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                // The row that holds the hospital's address.
                Row(
                  children: [
                    // Load the location icon as a SVG asset.
                    SvgPicture.asset(
                      ImageAssetSVG.locationIcon,
                      fit: BoxFit.none,
                      height: 13.h,
                      width: 13.w,
                    ),
                    SizedBox(width: 5.w),
                    // The text widget that displays the hospital's address.
                    Text(
                      hospitalModel.address,
                      style: TextStyle(
                          color: AppColor.fontColor2,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // The icon button that allows the user to call the hospital's phone number.
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: IconButton(
                onPressed: () {
                  controller.makePhoneCall(phoneNum: hospitalModel.phoneNunber);
                },
                // Set the color of the icon button to the main color of the theme.
                color: AppColor.mainColor,
                // Set the icon of the icon button to the phone icon.
                icon: const Icon(Icons.phone_enabled_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
