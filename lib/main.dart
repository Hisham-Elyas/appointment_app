import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:feedback/feedback.dart';

import 'core/constant/routes.dart';
import 'core/localization/changelocal_controller.dart';
import 'core/localization/translations.dart';
import 'core/services/services.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      builder: (controller) => ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => BetterFeedback(
                theme: controller.feedbackTheme,
                localeOverride: controller.language,
                child: GetMaterialApp(
                  locale: controller.language,
                  translations: MyTranslations(),
                  debugShowCheckedModeBanner: false,
                  title: 'Cuer City',
                  theme: controller.appTheme,
                  // darkTheme: controller.getThemeDark(),
                  // home: const OnBoarding(),
                  // home: const LocalNotificationScreenTest(),
                  getPages: AppRoutes.myPages,
                ),
              )),
    );
  }
}
