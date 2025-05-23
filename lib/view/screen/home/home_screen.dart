import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/doctor_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/static_data.dart';
import '../../../core/constant/string.dart';
import '../../../data/model/doctor_model.dart';
import '../../widget/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Find_your_desire_healt_solution.tr,
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .color),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  /// search bar

                  SizedBox(height: 20.h),

                  /// Category Widget
                  SizedBox(
                    height: 100.h,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.5,
                      ),
                      itemCount: categoryHomeList.length,
                      itemBuilder: (context, index) => CategoryWidget(
                        img: categoryHomeList[index].img,
                        name: categoryHomeList[index].name.tr,
                        onTap: () {
                          switch (categoryHomeList[index].name) {
                            case 'Doctor':
                              Get.toNamed(AppRoutes.getDoctorsScreen());

                              break;
                            case 'Pharmacy':
                              Get.toNamed(AppRoutes.getDrugsScrren());

                              break;
                            case 'Hospital':
                              Get.toNamed(AppRoutes.getHospitalScreen());

                              break;
                            case 'Ambulance':
                              Get.toNamed(AppRoutes.getAmbulancScreen());

                              break;
                            default:
                          }
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// bnaer
                  // Image.asset("assets/images/CTA.png"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w)
                        .copyWith(top: 5.h),
                    height: 135.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 5.w, bottom: 20.h),
                        child: Text(
                          Early_protection_for_your_family_health.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/images/ctaDoctor.png",
                        width: 91.w,
                        height: 131.h,
                        fit: BoxFit.contain,
                      ),
                    ]),
                  ),
                  SizedBox(height: 20.h),

                  //// Top Doctor
                  Container(
                    // margin: EdgeInsetsDirectional.only(start: 20.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Top_Doctor.tr,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsetsDirectional.only(start: 20.w, bottom: 10.h),
                // height: 190.h,
                child: GetBuilder<DoctorController>(builder: (controller) {
                  final doctors = controller.doctorlist;
                  return HandlingDataView(
                      imgHeight: 100.h,
                      statusReq: controller.statusReq,
                      onPressedReload: controller.getAllDoctors,
                      widget: RefreshIndicator(
                        onRefresh: controller.getAllDoctors,
                        child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 15.w),
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => DoctorWidget(
                                  doctor: doctors[index],
                                  onTap: () {
                                    Get.toNamed(AppRoutes.getDoctorDetailScrren(
                                        doctors[index]));
                                  },
                                )),
                      ));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorWidget extends StatelessWidget {
  final void Function() onTap;
  final Doctor doctor;
  const DoctorWidget({
    Key? key,
    required this.onTap,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      splashColor: Theme.of(context).colorScheme.secondary,
      highlightColor: AppColor.mainColor3,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w)
            .copyWith(top: 15.h, bottom: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
        ),
        height: 180.h,
        width: 118.w,
        child: Column(children: [
          CircleAvatar(
            radius: 40.r,
            backgroundImage: const AssetImage(
                'assets/images/pexels-cedric-fauntleroy-4270371.png'),
          ),
          SizedBox(height: 18.h),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 100,
              child: Text(
                doctor.name!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 100,
              child: Text(
                overflow: TextOverflow.ellipsis,
                doctor.specialty!,
                style: TextStyle(
                    color: AppColor.fontColor2,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: 13.h,
                  width: 28.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: Theme.of(context).colorScheme.secondary),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssetSVG.starIcon,
                        // color: AppColor.mainColor,
                        fit: BoxFit.none,
                        height: 13.h,
                        width: 13.w,
                      ),
                      Text(
                        '4,7',
                        style: TextStyle(
                            color: AppColor.mainColor,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
              SizedBox(width: 5.w),
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
                  SizedBox(
                    width: 40,
                    child: Text(
                      doctor.address!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColor.fontColor2,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
