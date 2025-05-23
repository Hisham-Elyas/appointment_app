import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/routes.dart';
import '../../../../core/constant/static_data.dart';
import '../../../../core/constant/string.dart';
import '../../../widget/category_widget.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_search_bar.dart';
import 'search_doctor_screen.dart';

class DoctorsScrren extends StatelessWidget {
  const DoctorsScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Doctorss.tr,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),

              /// SearchBar
              CustomSearchBar(
                text: Find_doctor.tr,
                onTap: () {
                  showSearch(context: context, delegate: DoctorSearch());
                },
              ),
              SizedBox(height: 30.h),
              Text(Category.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 18.h),
              Expanded(
                // height: 90.h,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.8),
                  itemCount: categoryDoctorList.length,
                  itemBuilder: (context, index) => CategoryWidget(
                    img: categoryDoctorList[index].img,
                    name: categoryDoctorList[index].name.tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.getDoctorListScreen(
                          categoryDoctorList[index].name));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
