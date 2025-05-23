import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:jiffy/jiffy.dart';

import '../../../../controller/chats_controller.dart';
import '../../../../core/class/enums.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/string.dart';
import '../../../../data/model/doctor_model.dart';
import '../../../../data/model/message_model.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_form_field.dart';

class ChatsScreen extends GetView<ChatsController> {
  final Doctor doctor;
  const ChatsScreen({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dr. ${doctor.name}',
        onTapTitle: () {
          Get.toNamed(AppRoutes.getDoctorDetailScrren(doctor));
        },
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: 25.w,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {},
              child: SvgPicture.asset(
                ImageAssetSVG.phoneIcon,
                width: 25.w,
                height: 25.h,
              ),
            ),
          ),
        ],
      ),
      body: Column(children: [
        SizedBox(height: 20.h),
        StreamBuilder<List<MessageModel>>(
            stream: controller.getMessage(contactId: doctor.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: HandlingDataView(
                    widget: SizedBox(),
                    statusReq: StatusRequest.loading,
                  ),
                );
              } else if (snapshot.hasError) {
                return Expanded(
                  child: Center(
                      child: Text(Error_Try_Later.tr,
                          style: TextStyle(
                            color: AppColor.fontColor5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ))),
                );
              } else if (snapshot.data!.isEmpty) {
                return Expanded(
                    child: Center(
                        child: Text(
                            Say_Hi_You_can_consult_your_problem_to_the_doctor
                                .tr)));
              } else {
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      controller.setSeenMessage(
                          doctor: doctor, msg: snapshot.data![index]);
                      final bool isMe =
                          snapshot.data![index].senderId! != doctor.id!;
                      return BubbleMessageWidget(
                        isMe: isMe,
                        message: snapshot.data![index],
                      );
                    },
                  ),
                );
              }
            }),
        GetBuilder<ChatsController>(builder: (chatcontroller) {
          return Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.all(8.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: CustomTextFormField(
                      hintText: Type_message.tr,
                      controller: chatcontroller.textEditingCont,
                      onChanged: chatcontroller.setMassages,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                CustomButton(
                  height: 60.h,
                  onPressed: chatcontroller.massages.isEmpty
                      ? null
                      : () => chatcontroller.sendMassages(doctor: doctor),
                  child: chatcontroller.isSending
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send, color: Colors.white),
                )
              ],
            ),
          );
        }),
      ]),
    );
  }
}

class BubbleMessageWidget extends StatelessWidget {
  final MessageModel message;
  const BubbleMessageWidget({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              EdgeInsetsDirectional.all(10.w).add(EdgeInsetsDirectional.only(
            start: isMe ? 120.w : 15.w,
            end: isMe ? 15.w : 120.w,
          )),
          padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w)
              .add(EdgeInsets.only(top: 12.h, bottom: 5.h)),
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).colorScheme.secondary
                : AppColor.mainColor,
            borderRadius: BorderRadiusDirectional.only(
              topStart: isMe ? Radius.circular(15.r) : Radius.zero,
              topEnd: isMe ? Radius.zero : Radius.circular(15.r),
            ).add(BorderRadius.vertical(bottom: Radius.circular(15.r))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(message.message!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: isMe ? AppColor.fontColor6 : Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp)),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isMe) ...[
                    Icon(
                      message.isSeen ? Icons.done_all : Icons.done,
                      color: message.isSeen ? Colors.blue : Colors.grey,
                      size: 16.dm,
                    ),
                    SizedBox(width: 10.w)
                  ],
                  Text(Jiffy.parseFromDateTime(message.timestamp!.toDate()).jm,
                      style: TextStyle(
                          color:
                              isMe ? AppColor.fontColor3 : Colors.grey.shade100,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
