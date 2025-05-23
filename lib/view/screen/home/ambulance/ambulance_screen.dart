// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../controller/ambulance_controller.dart';
import '../../../../core/class/enums.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../data/model/ambulance_model.dart';
import '../../../widget/custom_app_bar.dart';

class AmbulanceScreen extends StatelessWidget {
  const AmbulanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Ambulance", actions: [
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
          child: GetBuilder<AmbulanceController>(
            builder: (controller) => HandlingDataView(
                onPressedReload: () {
                  controller.getAllAmbulance();
                },
                statusReq: controller.statusReq,
                widget: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 13.h),
                  itemCount: controller.hospitalList.length,
                  itemBuilder: (context, index) => AmbulanceWidget(
                    ambulanceModel: controller.hospitalList[index],
                    onTap: () {},
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class AmbulanceWidget extends GetView<AmbulanceController> {
  final void Function() onTap;
  final AmbulanceModel ambulanceModel;

  const AmbulanceWidget({
    Key? key,
    required this.onTap,
    required this.ambulanceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      splashColor: Theme.of(context).colorScheme.secondary,
      highlightColor: AppColor.mainColor3,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
        ),
        height: 130.h,
        width: 334.w,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SvgPicture.asset(
                ImageAssetSVG.ambulanceLogo,
              ),
            ),
          ),
          SizedBox(width: 18.w),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ambulanceModel.name,
                style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5.h),
              Container(
                  height: 18.h,
                  width: 41.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: Theme.of(context).colorScheme.secondary),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        ImageAssetSVG.starIcon,
                        // color: AppColor.mainColor,
                        fit: BoxFit.none,
                        height: 13.h,
                        width: 13.w,
                      ),
                      // Icon(
                      //   Icons.star,
                      //   size: 13.h,
                      //   color: AppColor.mainColor,
                      // ),
                      Text(
                        '4,7',
                        style: TextStyle(
                            color: AppColor.mainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
              SizedBox(height: 12.h),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssetSVG.locationIcon,
                    // color: AppColor.mainColor,
                    fit: BoxFit.none,
                    height: 13.h,
                    width: 13.w,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    ambulanceModel.address,
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
          Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: IconButton(
                  onPressed: () {
                    controller.makePhoneCall(
                        phoneNum: ambulanceModel.phoneNunber);
                  },
                  color: AppColor.mainColor,
                  icon: const Icon(Icons.phone_enabled_rounded))),
        ]),
      ),
    );
  }
}
