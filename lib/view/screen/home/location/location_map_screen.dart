import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../controller/location_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_search_bar.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Location.tr,
      ),
      body: SizedBox(
        height: double.maxFinite,
        child: GetBuilder<LocationController>(
            builder: (locationController) => HandlingDataView(
                  statusReq: locationController.statusReq,
                  widget: Stack(
                    children: [
                      /// google Map

                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: locationController.initialPostion),
                        markers: locationController.currentMarker,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        onCameraIdle: () {
                          locationController.setisVisibilityConfirmBox = true;
                        },
                        onCameraMove: (position) {
                          locationController.currentCameraPostion = position;
                          locationController.setisVisibilityConfirmBox = false;
                        },
                        onMapCreated:
                            (GoogleMapController mapController) async {
                          locationController.setMapController(mapController);
                          await locationController.animateCameratoMyPosition(
                              latlng: locationController.initialPostion);
                        },
                        onTap: (argument) {
                          locationController.addMarker(position: argument);
                        },
                      ),

                      /// search bar
                      Visibility(
                        visible: locationController.isVisibilityConfirmBox,
                        child: Positioned(
                            top: 13,
                            left: 10,
                            right: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomSearchBar(
                                      text: Search_location_ZIP_code.tr),
                                ),
                                SizedBox(width: 10.w),
                                Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColor.mainColor2),
                                  child: IconButton(
                                      color: AppColor.mainColor,
                                      onPressed: () {
                                        locationController.goToMyLocation();
                                      },
                                      icon: const Icon(
                                        Icons.my_location,
                                        color: AppColor.mainColor,
                                      )),
                                )
                              ],
                            )),
                      ),
                      // Confirm box Button
                      Visibility(
                        visible: locationController.isVisibilityConfirmBox,
                        child: Positioned(
                          bottom: 15,
                          left: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 20.w),
                            height: 200.h,
                            width: 335.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Theme.of(context).colorScheme.surface),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Confirm_your_address.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .color,
                                        fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 5.h),
                                  const Divider(color: AppColor.mainColor3),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                          ImageAssetSVG.location2Icon),
                                      SizedBox(
                                        width: 250.w,
                                        // height: 50,
                                        child: Text(
                                          locationController.address,
                                          softWrap: true,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.fontColor6,
                                              fontSize: 14.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomButton(
                                    height: 50.h,
                                    width: 327.w,
                                    text: Confirm_Location.tr,
                                    onPressed:
                                        locationController.showAddressDialog,
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
