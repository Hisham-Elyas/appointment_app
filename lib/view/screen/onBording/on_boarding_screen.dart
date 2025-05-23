import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/onbording_controller.dart';
import '../../../core/constant/static_data.dart';
import 'widget/on_bording_widget.dart';

class OnBoarding extends GetView<OnBordingController> {
  const OnBoarding({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OnBordingController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: PageView.builder(
            controller: controller.myPageController,
            onPageChanged: (value) => controller.onPageChanged(value),
            itemCount: onBoardingList.length,
            itemBuilder: (context, index) => OnBordingWidet(
                  discription: onBoardingList[index].discription,
                  img: onBoardingList[index].img,
                  onTapNext: () => controller.nextPage(),
                  onTapSkip: () => controller.skip(),
                )),
      ),
    );
  }
}
