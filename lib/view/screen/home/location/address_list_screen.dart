import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/location_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/string.dart';
import '../../../widget/custom_app_bar.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Address.tr,
        actions: [
          Container(
              height: 40.w,
              width: 40.w,
              alignment: Alignment.center,
              margin: EdgeInsetsDirectional.only(end: 20.w, top: 15.h),
              decoration: BoxDecoration(
                  color: AppColor.mainColor3,
                  borderRadius: BorderRadius.circular(15.r)),
              child: InkWell(
                child: const Icon(
                  Icons.add,
                  color: AppColor.mainColor,
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.getLocationScreen());
                },
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GetBuilder<LocationController>(
          builder: (controller) => controller.myLocationlist.isEmpty
              ? Center(child: Text(Add_location.tr))
              : ListView.builder(
                  itemCount: controller.myLocationlist.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        highlightColor: AppColor.mainColor,
                        child: ListTile(
                          title: Text(
                            "${index + 1} - ${controller.myLocationlist[index].addressType}",
                            style: const TextStyle(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading:
                              SvgPicture.asset(ImageAssetSVG.location2Icon),
                          trailing: IconButton(
                              color: const Color(0xffcf6679),
                              onPressed: () {
                                controller.deletLocation(index);
                              },
                              icon: const Icon(Icons.delete)),
                          subtitle: Text(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              controller.myLocationlist[index].address),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
