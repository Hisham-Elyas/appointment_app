import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constant/app_color.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  // final BuildContext context;
  const ExpandableText({
    super.key,
    required this.text,
    // required this.context,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool isHidden = true;

  double textHeight = MediaQuery.of(Get.context!).size.height / 2;

  //5.63/ 7.73    101

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              style: TextStyle(
                color: AppColor.fontColor3,
                fontSize: 12.sp,
              ),
            )
          : SizedBox(
              // height: isHidden ? null : 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHidden ? '$firstHalf...' : firstHalf + secondHalf,
                    style: TextStyle(
                      color: AppColor.fontColor3,
                      fontSize: 12.sp,
                    ),
                  ),
                  TextButton.icon(
                    icon: Icon(
                      isHidden ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: AppColor.mainColor,
                    ),
                    label: Text(
                      isHidden ? 'Show more' : 'Show lass',
                      style: const TextStyle(
                        color: AppColor.fontColor3,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
