import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/doctor_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/string.dart';
import '../../../../core/functions/get_device_locale.dart';
import '../../../../data/model/doctor_model.dart';

class DoctorSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Get.focusScope!.unfocus();
          await Future.delayed(const Duration(milliseconds: 400));
          Get.close(1);
        },
        icon: Icon(getdeviceLocale(
            en: Icons.arrow_back_ios_new, ar: Icons.arrow_back_ios)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchWidget(query: query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchWidget(query: query);
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.query,
  });

  final String query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GetBuilder<DoctorController>(builder: (controller) {
        final doctorData = controller.filter(query);

        return doctorData == null
            ? Center(child: Text(No_data.tr))
            : HandlingDataView(
                statusReq: controller.statusReq,
                widget: doctorData.isEmpty
                    ? Center(child: Text(No_Match_Fond.tr))
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: doctorData.length,
                        itemBuilder: (context, index) {
                          return DoctorWidget(
                            doctor: doctorData[index],
                            onTap: () {
                              Get.toNamed(AppRoutes.getDoctorDetailScrren(
                                  doctorData[index]));
                            },
                          );
                        }),
              );
      }),
    );
  }
}

class DoctorWidget extends StatelessWidget {
  final Doctor doctor;

  final void Function() onTap;
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
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
        ),
        height: 100.h,
        width: 334.w,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          CircleAvatar(
            radius: 40.r,
            backgroundImage: const AssetImage(
                'assets/images/pexels-cedric-fauntleroy-4270371.png'),
          ),
          SizedBox(width: 18.w),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name!,
                style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                doctor.specialty!,
                style: TextStyle(
                    color: AppColor.fontColor2,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5.w),
              Row(
                children: [
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
                          Text(
                            '4,7',
                            style: TextStyle(
                                color: AppColor.mainColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  SizedBox(width: 15.w),
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
                        doctor.address!,
                        style: TextStyle(
                            color: AppColor.fontColor2,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
