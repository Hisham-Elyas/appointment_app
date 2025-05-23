import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/class/enums.dart';
import '../core/constant/app_color.dart';
import '../core/constant/image_asset.dart';
import '../core/constant/routes.dart';
import '../core/constant/string.dart';
import '../core/functions/ckeck_internet.dart';
import '../core/functions/show_coustom_snackbar.dart';
import '../core/services/services.dart';
import '../data/model/location_model.dart';
import '../view/widget/custom_text_form_field.dart';
import 'order_controller.dart';

class LocationController extends GetxController {
  final GlobalKey<FormState> addressformKey = GlobalKey();
  LatLng initialPostion = const LatLng(0, 0);
  late GoogleMapController mapController;
  late CameraPosition currentCameraPostion;
  List<Placemark> placemark = [];
  Set<Marker> currentMarker = <Marker>{};
  List<LocationModel> myLocationlist = [];
  String address = You_have_not_selected_location.tr;
  bool isVisibilityConfirmBox = true;
  late Position myPosition;
  StatusRequest statusReq = StatusRequest.success;
  @override
  void onInit() async {
    super.onInit();
    // statusReq = StatusRequest.loading;
    // update();
    getmyLocationlist();
    await setCustomMarkerIcon();
    myPosition = await getDetermineAndPosition();
    currentCameraPostion = CameraPosition(
        zoom: 18, target: LatLng(myPosition.latitude, myPosition.longitude));
    initialPostion = LatLng(myPosition.latitude, myPosition.longitude);
    await getplacemarkFromCoordinates(
        position: LatLng(myPosition.latitude, myPosition.longitude));
    currentMarker.clear();
    currentMarker.add(Marker(
        markerId: const MarkerId('1'),
        icon: sourceIcon,
        position: LatLng(myPosition.latitude, myPosition.longitude)));

    // statusReq = StatusRequest.loading;
    // Future.delayed(const Duration(seconds: 5));
    // statusReq = StatusRequest.success;
    // update();
  }

  set setisVisibilityConfirmBox(value) {
    isVisibilityConfirmBox = value;
    update();
  }

  MyServices myServices = Get.find();
  void showAddressDialog() {
    if (address == You_have_not_selected_location.tr) {
      showCustomSnackBar(
          message: You_have_not_selected_location.tr,
          title: LocationInfo.tr,
          isError: true);
      return;
    }
    Get.defaultDialog(
      title: Save_Address.tr,
      barrierDismissible: false,
      titlePadding: EdgeInsets.only(top: 20.h),
      contentPadding: EdgeInsets.all(20.h),
      buttonColor: AppColor.mainColor,
      radius: 30.r,
      titleStyle: TextStyle(
        color: Theme.of(Get.context!).textTheme.displayLarge!.color,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      content: const AddressDialog(),
    );
  }

  void confirmAddress() async {
    if (!addressformKey.currentState!.validate() ||
        address == You_have_not_selected_location.tr) {
      // Invalid!
      return;
    }

    addressformKey.currentState!.save();
    Get.focusScope!.unfocus();
    myLocationlist.add(LocationModel(
        addressType: _userAddress!,
        address: address,
        longitude: currentCameraPostion.target.longitude,
        latitude: currentCameraPostion.target.latitude));
    await myServices.sharedPreferences
        .setString("My_Location", jsonEncode(myLocationlist));
    Get.close(1);
    Get.back();

    update();
  }

  String? _userAddress;
  set setuserAddress(val) => _userAddress = val;
  String? addressvalidator(String? val) {
    if (val!.isEmpty) {
      return Enter_your_address_name.tr;
    }
    return null;
  }

  void deletLocation(index) async {
    myLocationlist.removeAt(index);
    await myServices.sharedPreferences
        .setString("My_Location", jsonEncode(myLocationlist));
    update();
  }

  void selectAddress() async {
    Get.bottomSheet(
        backgroundColor: Theme.of(Get.context!).colorScheme.surface,
        const ChoosesAddressWidget());
  }

  void getmyLocationlist() {
    final cacheData = myServices.sharedPreferences.getString("My_Location");
    if (cacheData != null) {
      final List data = jsonDecode(cacheData);
      myLocationlist.addAll(data.map((e) => LocationModel.fromJson(e)));
    }
  }

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  Future<void> setCustomMarkerIcon() async {
    await BitmapDescriptor.asset(ImageConfiguration.empty,
            "assets/images/LocationMapIcon.png") //assets/images/LocationMapIcon.png
        .then((icon) => sourceIcon = icon);
  }

  void goToMyLocation() async {
    final Position myPosition = await getDetermineAndPosition();
    await animateCameratoMyPosition(
        latlng: LatLng(myPosition.latitude, myPosition.longitude));
    currentMarker.add(Marker(
        markerId: const MarkerId('1'),
        icon: sourceIcon,
        position: LatLng(myPosition.latitude, myPosition.longitude)));
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void addMarker({required LatLng position}) {
    currentMarker.clear();
    currentMarker.add(Marker(
        icon: sourceIcon,
        markerId: const MarkerId('1'),
        position: LatLng(position.latitude, position.longitude)));
    getplacemarkFromCoordinates(position: position);
    update();
  }

  Future<List<Placemark>> getplacemarkFromCoordinates(
      {required LatLng position}) async {
    MyServices myServices = Get.find();
    String? sharedlang = myServices.sharedPreferences.getString("lang");
    if (await ckeckInternet()) {
      placemark = await placemarkFromCoordinates(
        position.latitude, position.longitude,

        // localeIdentifier: sharedlang ?? "en"
      );

      address = '${placemark[0].street ?? ''} ,'
          '${placemark[0].subAdministrativeArea ?? ''} ,'
          '${placemark[0].administrativeArea ?? ''}, '
          '${placemark[0].country ?? ''}, ';
    }
    update();
    return placemark;
  }

  Future<Position> getDetermineAndPosition() async {
    // bool serviceEnabled;
    LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      log('====================================');
      log('==================$permission==================');

      log('====================================');
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> animateCameratoMyPosition({required LatLng latlng}) async {
    await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latlng.latitude, latlng.longitude), zoom: 18)));
  }
}

class ChoosesAddressWidget extends StatelessWidget {
  const ChoosesAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
          height: 370,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    Choose_address_for_Delivery.tr,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: AppColor.mainColor3,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: IconButton(
                          color: AppColor.mainColor,
                          onPressed: () {
                            Get.toNamed(AppRoutes.getLocationScreen());
                          },
                          icon: const Icon(Icons.add))),
                ],
              ),
              const Divider(color: AppColor.mainColor3),
              GetBuilder<LocationController>(
                builder: (controller) => Expanded(
                  child: controller.myLocationlist.isEmpty
                      ? Center(
                          child: Text(
                          Add_location.tr,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ))
                      : ListView.builder(
                          itemCount: controller.myLocationlist.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                highlightColor: AppColor.mainColor,
                                onTap: () async {
                                  Get.find<OrderController>().ordering(
                                      location:
                                          controller.myLocationlist[index]);
                                },
                                child: ListTile(
                                  title: Text(
                                    "${index + 1} - ${controller.myLocationlist[index].addressType}",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .color),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: SvgPicture.asset(
                                      ImageAssetSVG.location2Icon),
                                  trailing: IconButton(
                                      color: const Color(0xffcf6679),
                                      onPressed: () {
                                        controller.deletLocation(index);
                                      },
                                      icon: const Icon(Icons.delete)),
                                  subtitle: Text(
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .color),
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
            ],
          )),
    );
  }
}

class AddressDialog extends GetView<LocationController> {
  const AddressDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Form(
        key: controller.addressformKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              hintText: Enter_your_address_name.tr,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) => controller.addressvalidator(val),
              onSaved: (val) => controller.setuserAddress = val,
            ),
            SizedBox(height: 10.h),
            const Divider(color: AppColor.mainColor3),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(ImageAssetSVG.location2Icon),
                SizedBox(
                  width: 200.w,
                  // height: 50,
                  child: Text(
                    controller.address,
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
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Get.close(1);
                    },
                    style: const ButtonStyle(
                        side: WidgetStatePropertyAll(
                            BorderSide(width: 2, color: AppColor.mainColor))),
                    child: Text(Cancel.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ))),
                ElevatedButton(
                  style: const ButtonStyle(
                      elevation: WidgetStatePropertyAll(5),
                      backgroundColor:
                          WidgetStatePropertyAll(AppColor.mainColor)),
                  onPressed: () {
                    controller.confirmAddress();
                  },
                  child: Text(
                    Confirm.tr,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
