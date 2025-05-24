import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/static_data.dart';
import '../core/services/services.dart';

class OnBordingController extends GetxController {
  int currentPage = 0;
  MyServices myServices = Get.find();
  late final PageController myPageController = PageController();
  nextPage() {
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      myServices.sharedPreferences.setBool('OnBording', true);
      Get.toNamed(AppRoutes.getStartScreen());
    } else {
      myPageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  skip() {
    Get.toNamed(AppRoutes.getStartScreen());
    myServices.sharedPreferences.setBool('OnBording', true);
  }

  onPageChanged(int value) {
    currentPage = value;
    update();
  }
}
