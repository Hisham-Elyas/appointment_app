import '../../middleware/middleware.dart';
import '../../view/screen/home/chats/chats_screen.dart';
import 'package:get/get.dart';

import '../../controller/chats_controller.dart';
import '../../data/model/doctor_model.dart';
import '../../view/screen/auth/create_new_password_screen.dart';
import '../../view/screen/auth/login_screen.dart';
import '../../view/screen/auth/reset_password_screen.dart';
import '../../view/screen/auth/sign_up_screen.dart';
import '../../view/screen/auth/verify_code_screen.dart';
import '../../view/screen/home/Schedule/schedule_screen.dart';
import '../../view/screen/home/ambulance/ambulance_screen.dart';
import '../../view/screen/home/doctors/doctors_detail_screen.dart';
import '../../view/screen/home/doctors/doctors_list_screen.dart';
import '../../view/screen/home/doctors/doctors_screen.dart';
import '../../view/screen/home/drugs/cart_screen.dart';
import '../../view/screen/home/drugs/drugs_screen.dart';
import '../../view/screen/home/hospital/hospital_screen.dart';
import '../../view/screen/home/location/location_map_screen.dart';
import '../../view/screen/home/main_screen.dart';
import '../../view/screen/home/location/address_list_screen.dart';
import '../../view/screen/home/profile/my_favorite_screen.dart';
import '../../view/screen/home/notifications/notifications_screen.dart';
import '../../view/screen/home/profile/feedback_sereen.dart';
import '../../view/screen/home/order/order_screen.dart';
import '../../view/screen/home/profile/settings_screen.dart';
import '../../view/screen/onBording/on_boarding_screen.dart';
import '../../view/screen/onBording/start_screen.dart';

class AppRoutes {
  static const String onBoarding = '/';
  static const String startScreen = '/Start-Screen';
  static const String loginScreen = '/Login-Screen';
  static const String signUpScreen = '/SignUp-Screen';
  static const String resetPasswordScreen = '/Reset-Password';
  static const String verifyCodeScreen = '/Verify-Code';
  static const String createNewPasswordScreen = '/Create-New-Password';
  static const String homeScreen = '/Home-Screen';

  /// Drugs-Screen
  static const String drugsScrren = '/Drugs-Screen';
  static const String drugsDetailScrren = '/Drugs-Detail-Screen';
  static const String drugsCartScreen = '/Drugs-Cart-Screen';
  static const String drugsSearchScreen =
      '/Drugs-Search-Screen'; //SearchDrugsScreen
  /////  DoctorsScrren
  static const String doctorsScrren = '/Doctors-Screen';
  static const String doctorDetailScrren = '/Doctor-Detail-Screen';
  static const String doctorListScreen = '/Doctor-List-Screen';

  static const String favoriteScreen = '/Favorite-Screen';
  static const String scheduleScreen = '/Schedule-Screen';
  static const String chatsScreen = '/Chats-Screen';
  static const String locationScreen = '/Location-Screen';
  static const String feedbackScreen = '/Feedback-Screen';
  static const String addressListScreen = '/Address_List-Screen';
  static const String notificationsScreen = '/Notifications-Screen';
  static const String orderScreen = '/Order-Screen';
  static const String settingsScreen = '/Settings-Screen';
  static const String hospitalScreen = '/Hospital-Screen';
  static const String ambulancScreen = '/Ambulanc-Screen';
  static String getOnBoardingn() => onBoarding;
  static String getStartScreen() => startScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getResetPasswordScreen() => resetPasswordScreen;
  static String getVerifyCodeScreen() => verifyCodeScreen;
  static String getCreateNewPasswordScreen() => createNewPasswordScreen;
  static String getHomeScreen() => homeScreen;
  static String getLocationScreen() => locationScreen;
  static String getAddressListScreen() => addressListScreen;
  static String getFeedbackScreen() => feedbackScreen;
  static String getNotificationsScreen() => notificationsScreen;
  static String getOrderScreen() => orderScreen;
  static String getHospitalScreen() => hospitalScreen;
  static String getAmbulancScreen() => ambulancScreen;
  static String getSettingsScreen() => settingsScreen;

  /// profile screen

  static String getFavoriteScreen() => favoriteScreen;
  static String getScheduleScreen() => scheduleScreen;
  static String getChatsScreenScreen(Doctor doctorinfo) =>
      "$chatsScreen?Doctorinfo=${doctorinfo.toJson()}";

  /// Drugs-Screen
  static String getDrugsScrren() => drugsScrren;
  static String getDrugsDetailScrren() => drugsDetailScrren;
  static String getDrugsCartScreen() => drugsCartScreen;
  static String getDrugsSearchScreen() => drugsSearchScreen;
  /////  DoctorsScrren
  static String getDoctorsScreen() => doctorsScrren;
  static String getDoctorDetailScrren(Doctor doctorinfo) =>
      '$doctorDetailScrren?Doctorinfo=${doctorinfo.toJson()}';
  static String getDoctorListScreen(String category) =>
      '$doctorListScreen?Category=$category';
  static List<GetPage<dynamic>>? myPages = [
    GetPage(
        name: onBoarding,
        page: () => const OnBoarding(),
        middlewares: [MyMiddleware()],
        transition: Transition.circularReveal),
    GetPage(
        name: startScreen,
        page: () => const StartScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: loginScreen,
        page: () => const LoginScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: signUpScreen,
        page: () => const SignUpScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: resetPasswordScreen,
        page: () => const ResetPasswordScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: verifyCodeScreen,
        page: () => const VerifyCodeScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: createNewPasswordScreen,
        page: () => const CreateNewPasswordScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: homeScreen,
        // page: () => const HomeScreen(),
        // bindings: const [
        //   // BindingsBuilder.put(() => DrugsController()),
        //   // BindingsBuilder.put(() => DoctorController()),
        //   // BindingsBuilder.put(() => ApointmentController()),
        //   // BindingsBuilder.put(() => ChatsController()),
        // ],
        page: () => const MainScreen(),
        transition: Transition.circularReveal),

    /// Drugs-Screen
    GetPage(
        name: drugsScrren,
        page: () => const DrugsScrren(),
        transition: Transition.circularReveal),
    // GetPage(
    //     name: drugsDetailScrren,
    //     // page: () {
    //       // final product = Get.parameters['Product'];
    //       // return DrugsDetailScrren();
    //     // },
    //     transition: Transition.circularReveal),
    GetPage(
        name: drugsCartScreen,
        page: () => const CartScreen(),
        transition: Transition.circularReveal),
    // GetPage(
    //     name: drugsSearchScreen,
    //     page: () => const SearchDrugsScreen(),
    //     transition: Transition.circularReveal),
    /////  DoctorsScrren
    GetPage(
        name: doctorsScrren,
        page: () => const DoctorsScrren(),
        transition: Transition.circularReveal),
    GetPage(
        name: doctorDetailScrren, //Doctorinfo
        page: () {
          final doctorinfo = Doctor.fromJson(Get.parameters['Doctorinfo']!);
          // print(doctorinfo.name);
          // print(DoctorModel.fromMap(Doctorinfo));
          return DoctorDetailScrren(
            doctorinfo: doctorinfo,
          );
        },
        transition: Transition.circularReveal),
    GetPage(
        name: doctorListScreen,
        page: () {
          final category = Get.parameters['Category'];
          return DoctorListScreen(category: category!);
        },
        transition: Transition.circularReveal),
    GetPage(
        name: favoriteScreen,
        page: () {
          return const MyFavoriteScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: scheduleScreen,
        page: () {
          return const ScheduleScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: chatsScreen,
        page: () {
          final doctorinfo = Doctor.fromJson(Get.parameters['Doctorinfo']!);
          return ChatsScreen(doctor: doctorinfo);
        },
        bindings: [
          BindingsBuilder.put(() => ChatsController()),
        ],
        transition: Transition.circularReveal),
    GetPage(
        name: locationScreen,
        page: () {
          return const LocationScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: addressListScreen,
        page: () {
          return const AddressListScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: feedbackScreen,
        page: () {
          return const FeedbackScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: notificationsScreen,
        page: () {
          return const NotificationsScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: orderScreen,
        page: () {
          return const OrderScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: settingsScreen,
        page: () {
          return const SettingsScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: hospitalScreen,
        page: () {
          return const HospitalScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: ambulancScreen,
        page: () {
          return const AmbulanceScreen();
        },
        transition: Transition.circularReveal),
  ];
}
