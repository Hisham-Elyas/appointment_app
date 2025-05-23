import '../../../../core/functions/get_device_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../controller/chats_controller.dart';
import '../../../../controller/doctor_controller.dart';
import '../../../../core/class/enums.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/string.dart';
import '../../../../data/model/message_history_model.dart';
import '../../../widget/custom_app_bar.dart';
import 'search_message_screen.dart';

class MessageHistoryScreen extends GetView<ChatsController> {
  const MessageHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Message.tr,
        centerTitle: false,
        goBack: false,
        actions: [
          Container(
            height: 45.h,
            width: 45.w,
            padding: EdgeInsetsDirectional.only(end: 20.w),
            child: InkWell(
                borderRadius: BorderRadius.circular(50.r),
                onTap: () {
                  showSearch(context: context, delegate: MessageSearch());
                },
                child: SvgPicture.asset(
                  ImageAssetSVG.searchLogo,
                  // ignore: deprecated_member_use
                  color: AppColor.mainColor,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Stack(
          children: [
            Column(children: [
              const CustomTapWidget(),
              SizedBox(height: 30.h),
              GetBuilder<DoctorController>(builder: (drugsController) {
                return Expanded(
                  child: HandlingDataView(
                    onPressedReload: () {
                      drugsController.getAllDoctors();
                    },
                    statusReq: drugsController.statusReq,
                    buttonTextEmpty: '',
                    widget: StreamBuilder<List<MessageHistoryInUser>>(
                        stream: controller.getMessageHistory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const HandlingDataView(
                              widget: SizedBox(),
                              statusReq: StatusRequest.loading,
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(Error_Try_Later.tr,
                                    style: TextStyle(
                                      color: AppColor.fontColor5,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    )));
                          } else if (snapshot.data!.isEmpty) {
                            return Center(
                                child: Text(Start_Chatting_With_Youer_Doctor.tr,
                                    style: TextStyle(
                                      color: AppColor.fontColor3,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    )));
                          } else {
                            //// scroll down  when new messge add
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              controller.scrollController.jumpTo(controller
                                  .scrollController.position.maxScrollExtent);
                            });
                            return ListView.separated(
                                controller: controller.scrollController,
                                itemCount: snapshot.data!.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10.h),
                                itemBuilder: (context, index) =>
                                    MessageHistoryWidget(
                                      messageHistoryInUser:
                                          snapshot.data![index],
                                      onTap: () {
                                        Get.toNamed(
                                            AppRoutes.getChatsScreenScreen(
                                                snapshot.data![index].doctor!));
                                      },
                                    ));
                          }
                        }),
                  ),
                );
              }),
            ]),
            Positioned(
              bottom: 50.h,
              right: getdeviceLocale(en: 0.0, ar: null),
              left: getdeviceLocale(en: null, ar: 0.0),
              child: InkWell(
                onTap: () {
                  showSearch(context: context, delegate: MessageSearch());
                },
                borderRadius: BorderRadius.circular(30.r),
                child: CircleAvatar(
                  backgroundColor: AppColor.mainColor,
                  radius: 30.r,
                  child: SvgPicture.asset(
                    "assets/svg/Chat.svg",
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTapWidget extends StatelessWidget {
  const CustomTapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatsController>(
      builder: (controller) => Container(
        width: 335.w,
        height: 46.h,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8.r)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.taps.length,
          itemBuilder: (context, index) => InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              controller.setTapLIstNum = index;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              alignment: Alignment.center,
              width: 335.w / controller.taps.length,
              height: 46.h,
              decoration: BoxDecoration(
                  color: index == controller.tapLIstNum
                      ? AppColor.mainColor
                      : null,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Text(controller.taps[index].tr,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: index == controller.tapLIstNum
                          ? AppColor.backgroundColor
                          : AppColor.fontColor1)),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageHistoryWidget extends StatelessWidget {
  final void Function() onTap;
  final MessageHistoryInUser messageHistoryInUser;
  const MessageHistoryWidget({
    required this.onTap,
    Key? key,
    required this.messageHistoryInUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: Container(
          // height: 50.h,
          width: 335.w,
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.5.w, color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(8.r)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/UserAvatar.png"),
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dr. ${messageHistoryInUser.receiverName ?? ''}",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  width: 170.w,
                  child: Text(messageHistoryInUser.lastMessage ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ],
            ),
            const Spacer(),
            Text(
                Jiffy.parseFromDateTime(
                        messageHistoryInUser.timestamp!.toDate())
                    .jm,
                style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                )),
          ])),
    );
  }
}
