import 'package:get/get.dart';

import '../constant/string.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
//////////////  on boarding

          Lets_get_started: "هيا بنا نبدأ",
          Skip: "تخطي",
          Login_to_enjoy_the_features_weve_provided_and_stay_healthy:
              "قم بتسجيل الدخول لتستمتع بالميزات التي قدمناها، وحافظ على صحتك!",
          Consult_only_with_a_doctor_you_trust: "استشر فقط الطبيب الذي تثق به",
          Find_a_lot_of_specialist_doctors_in_one_place:
              "ابحث عن الكثير من الأطباء المتخصصين في مكان واحد",
          Get_connect_our_Online_Consultation:
              "احصل على اتصال بمشاورتنا عبر الإنترنت",

          ///////////////
          LOGIN: "تسجيل الدخول",
          EMAIL: "بريد إلكتروني",
          Phone: " رقم الهاتف",
          Enter_your_email: "أدخل بريدك الإلكتروني",
          Enter_your_password: "ادخل رقمك السري",
          Enter_your_name: "أدخل أسمك",
          Forgot_Password: "هل نسيت كلمة السر؟",
          Reset_Password: "إعادة تعيين كلمة المرور",
          Forgot_Your_Password: "نسيت كلمة السر؟",
          Dont_have_an_account: "ليس لديك حساب؟",
          Create_New_Password: 'إنشاء كلمة مرور جديدة',
          Create_Password: 'إنشاء كلمة المرور',
          Create_your_new_password_to_login:
              'قم بإنشاء كلمة المرور الجديدة لتسجيل الدخول',
          Enter_your_email_or_your_phone_number_we_will_send_you_confirmation_code:
              'أدخل بريدك الإلكتروني أو رقم هاتفك، وسنرسل لك \nرمز التأكيد',
          Sign_Up: 'اشتراك',
          Sign_In: 'تسجيل الدخول',
          OR: 'أو',
          Sign_in_with_Google: 'قم بتسجيل الدخول باستخدام جوجل',
          Sign_in_with_Apple: 'قم بتسجيل الدخول باستخدام أبل',
          Sign_in_with_Facebook: 'قم بتسجيل الدخول باستخدام الفيسبوك',
          I_agree_to_the_medidoc_Terms_of_Service_and_Privacy_Policy:
              'أوافق على شروط خدمة  \n سياسة الخصوصية',
          Enter_Verification_Code: 'أدخل رمز التحقق',
          Enter_code_that_we_have_sent_to_your_email:
              'أدخل الرمز الذي أرسلناه إلى بريدك الإلكتروني',
          Verify: 'تحقق',
          Didnt_receive_the_code: 'لم تتلق الرمز؟',
          Resend: 'إعادة إرسال',
          //// order screen
          pendingEnum: "قيد الانتظار",
          underwayEnum: "قيد التنفيذ",
          deliveredEnum: "تم التوصيل",
          closedEnum: "  تم الغلاق الطلب",
          cancelEnum: "تم الغاء الطلب",
          Choose_address_for_Delivery: "أختر عنوان للتوصيل",
          Add_location: "أضف عنوان",
          Enter_your_address_name: "أدخل اسم لعوانك",
          /////      Settings Screen
          Settings: 'الضبط',
          Address: 'عناوينى',
          Orders: 'الطلبات',
          English: 'إنجليزي',
          Arabic: 'العربية',
          Language: 'اللغة',
          Dark_Mode: 'الوضع الداكن',
          Report_a_Problem_Or_Leave_Feedback: 'الإبلاغ عن مشكلة أو أترك تعليق',
          /////       Profile Screen
          My_Saved: 'المفضلة',
          Appointmnet: "المواعيد",
          FAQs: 'الأسئلة الشائعة',
          Logout: 'تسجيل خروج',

          /////       My Favorite Screen

          Clear: 'مسح الكل',
          Add_product_to_your_favorite: 'أضف منتج إلى المفضلة لديك',
          /////       Schedule Screen

          Schedule: 'جدول المواعيد',
          Add_Appointment: 'إضافة موعد',
          Appointment_Added: "تم أضافة الموعد",
          Book_Appointment: "حجز موعد",
          Remind_Me: "زكرني",
          Done: "تم ✅",
          Appointment_Canceled: 'تم ألغاء الموعد 🗑 ',
          Appointment_Updated: 'تم تحديث الموعد  ',
          Confirm: "تأكيد",
          Date: "التاريخ",
          Change: "تغير",
          Upcoming: "القادمة",
          Completed: "مكتمل",
          Canceled: "ألغيت",
          Cancel: "إلغاء",
          Reschedule: "إعادة جدول المواعيد",
          Pending: "قيد الانتظار",
          Confirmed: "تم الموافقة",
          ////  Feedback  Screen
          feeedback: " أترك تعليق",
          Provide_feedback: "تقديم تعليق",
          How_feedback_it_work: '# كيف يعمل؟\n'
              '1. ما عليك سوى الضغط على زر "تقديم التعليقات" أو زر الرمز.\n'
              '2. يتم فتح عرض الملاحظات. '
              'يمكنك الاختيار بين وضع الرسم والتنقل. '
              'عندما تكون في وضع التنقل، يمكنك التنقل بحرية في'
              'برنامج. جربه عن طريق فتح درج التنقل '
              " وضع الرسم فقط اضغط على زر الرسم الموجود على اليمين"
              '  جانب . يمكنك الآن الرسم على الشاشة. \n '
              '3. لإنهاء ملاحظاتك فقط قم بكتابة رسالة '
              'أدناه وأرسله بالضغط على زر إرسال',

          //// Message Screen

          Message: "الرسائل",
          Error_Try_Later: "خطأ \n  حاول لاحقاً",
          Start_Chatting_With_Youer_Doctor: "خطأ \n  حاول لاحقاً",
          All: "الكل",
          Group: "المجموعات",
          Private: "الخاص",

          //// home Screen
          Find_your_desire_healt_solution: "ابحث عن الحل \nالصحي الذي تريدة",
          Search_doctor_drugs_articles: "بحث عن مقالات , طبيب , دواء",

          Doctors: "طبيب",
          Early_protection_for_your_family_health:
              "الحماية المبكرة\n لصحة عائلتك ",
          Pharmacy: "صيدلية",
          Hospital: "مستشفى",
          Ambulance: "سيارة إسعاف",
          Top_Doctor: "أفضل طبيب",
          See_all: "عرض الكل",
          ////  Doctor Screen
          Doctorss: "الأطباء",
          Doctor_Detail: "معلومات الطبيب",
          Booking: "حجز",
          About: "نبذة عن",
          Find_doctor: "بحث عن طبيب",
          Category: "التخصصات",
          General: "عام",
          Lungs_Specialist: "أخصائي الرئتين",
          Dentist: "أسنان",
          Psychiatrist: "نفسي",
          Surgeon: "جراحة",
          Cardiologist: "القلب",
          Covid: "كورونا",
          Popular_Product: "أكثر مبيعاً",
          Favorite_Product: "المفضلة",
          Search_drugs_category: "بحث عن دواء",

          /// cart Screen

          My_Cart: "عربة التسوق",
          Cart: "عربة التسوق 🛒",
          History: "السجل",
          XProduct: "منتج",
          Ongoing: "جاري التنفذ",
          Orders_Details: "تفاصبل الطلب",
          Your_cart_is_Empty: "عربة التسوق فارقة!",
          You_should_at_least_add_an_item_in_the_cart:
              "يجب أضافة عنصر واحد على الاقل",
          Total: "المجموع",
          Checkout: "الدفع",
          Drugs_Item: "عربة الادوية 💊",
          add_to_cart: "تمت إضافة إالى السلة ✅",
          Already_added_to_cart: " تمت إضافة العنصر إلى سلة التسوق مسبقا ❗",

          ///  Drug Screen
          Drugs_Detail: "تفاصيل الدواء",
          Strength: "التركيز",
          Generic_Name: "الاسم العلمي",
          Dosage_Form: "الشكل الصيدلاني",
          Route_of_Administration: "طريقة أخذ الدواء",
          Pacakge_Size: "حجم العبوة",
          SFDA_Code: "رقم التسجيل",
          Medical_bulletin: "النشرة الطبية",
          Add_to_cart: "اضافة إالى السلة",

          /// Chats Screen
          Loading: "تحميل...",
          No_Match_Fond: "لا يوجد تطابق",
          No_data: "لا يوجد بيانات",
          Type_message: "اكتب رسالة",
          Say_Hi_You_can_consult_your_problem_to_the_doctor:
              "قل مرحباً...👋\n يمكنك استشارة مشكلتك للطبيب",
          /////
          Errors: "خطأ ❗",
          Ckeck_your_Internet: "تفحص اتصال الإنترنت",
          Unexpected_Error: "خطأ غير متوقع ❗",
          Please_try_agein_later: "الرجاء تجربة في وقت أخر",
          No_valid_entry_found: "لايوجد بيانات حالياً",
          Please_try_something_else: "الرجاء تجربة شئ أخر ❗",
          Type_your_Name: "اكتب اسمك",
          Name_can_not_be_less_than_4_characters: "ادخل اسم صحيح",
          Enter_your_vlied_name: "ادخل اسم صحيح",
          Type_in_valid_email_adress: "ادخل إيميل صحيح",
          Type_your_email_adress: "اكتب إيميلك",
          Password_can_not_be_less_than_six_characters: "كلمة السر ضعيفة",
          Password_not_match: "كلمة السر غير متطابقة",
          //// Notifications
          Notifications: "الاشعارات",
          You_Have_Appointment_With: "لديك موعد مع د.",
          //// Location Screen
          Location: "الموقع",
          LocationInfo: " معلومات الموقع",
          Save_Address: "حفظ الموقع",
          You_have_not_selected_location: "لم تقم بأختيار موقع",
          Search_location_ZIP_code: "البحث عن عنوان",
          Confirm_Location: "تأكيد الموقع",
          Confirm_your_address: "تأكيد موقعك",
        },
        //////////////////////////////////////////
        "en": {
          ////
          Errors: Errors,
          Ckeck_your_Internet: Ckeck_your_Internet,
          Network_Info: Network_Info,
          Unexpected_Error: Unexpected_Error,
          Please_try_agein_later: Please_try_agein_later,
          No_valid_entry_found: No_valid_entry_found,
          Please_try_something_else: Please_try_something_else,
          Password_not_match: Password_not_match,
          Name_can_not_be_less_than_4_characters:
              Name_can_not_be_less_than_4_characters,
          Type_your_Name: Type_your_Name,
          Password_can_not_be_less_than_six_characters:
              Password_can_not_be_less_than_six_characters,
          Enter_your_vlied_name: Enter_your_vlied_name,
          Type_your_email_adress: Type_your_email_adress,
          Type_in_valid_email_adress: Type_in_valid_email_adress,
          //////////////  on boarding

          Lets_get_started: Lets_get_started,
          Login_to_enjoy_the_features_weve_provided_and_stay_healthy:
              Login_to_enjoy_the_features_weve_provided_and_stay_healthy,
          Skip: Skip,
          Consult_only_with_a_doctor_you_trust:
              Consult_only_with_a_doctor_you_trust,
          Find_a_lot_of_specialist_doctors_in_one_place:
              Find_a_lot_of_specialist_doctors_in_one_place,
          Get_connect_our_Online_Consultation:
              Get_connect_our_Online_Consultation,
          ///////
          LOGIN: LOGIN,
          EMAIL: EMAIL,
          Phone: Phone,
          Enter_your_email: Enter_your_email,
          Enter_your_password: Enter_your_password,
          Reset_Password: Reset_Password,
          Forgot_Password: Forgot_Password,
          Forgot_Your_Password: Forgot_Your_Password,
          Create_New_Password: Create_New_Password,
          Create_Password: Create_Password,
          Create_your_new_password_to_login: Create_your_new_password_to_login,
          Enter_your_email_or_your_phone_number_we_will_send_you_confirmation_code:
              Enter_your_email_or_your_phone_number_we_will_send_you_confirmation_code,
          Enter_your_name: Enter_your_name,
          Dont_have_an_account: Dont_have_an_account,
          Sign_Up: Sign_Up,
          Sign_In: Sign_In,
          OR: OR,
          Sign_in_with_Google: Sign_in_with_Google,
          Sign_in_with_Apple: Sign_in_with_Apple,
          Sign_in_with_Facebook: Sign_in_with_Facebook,
          Enter_Verification_Code: Enter_Verification_Code,
          I_agree_to_the_medidoc_Terms_of_Service_and_Privacy_Policy:
              I_agree_to_the_medidoc_Terms_of_Service_and_Privacy_Policy,
          Enter_code_that_we_have_sent_to_your_email:
              Enter_code_that_we_have_sent_to_your_email,
          Verify: Verify,
          Didnt_receive_the_code: Didnt_receive_the_code,
          Resend: Resend,

          /// order Screen
          pendingEnum: pendingEnum,
          underwayEnum: underwayEnum,
          deliveredEnum: deliveredEnum,
          closedEnum: closedEnum,
          cancelEnum: cancelEnum,
          Choose_address_for_Delivery: Choose_address_for_Delivery,
          Add_location: Add_location,
          Enter_your_address_name: Enter_your_address_name,
          /////      Settings Screen
          Settings: Settings,
          Orders: Orders,
          Address: Address,
          English: English,
          Language: Language,
          Arabic: Arabic,
          Dark_Mode: Dark_Mode,
          Report_a_Problem_Or_Leave_Feedback:
              Report_a_Problem_Or_Leave_Feedback,
          /////       Profile Screen
          My_Saved: My_Saved,
          Appointmnet: Appointmnet,
          FAQs: FAQs,
          Logout: Logout,
          /////       My Favorite Screen

          Clear: Clear,
          Add_product_to_your_favorite: Add_product_to_your_favorite,
          /////       Schedule Screen

          Done: Done,
          Appointment_Updated: Appointment_Updated,
          Appointment_Canceled: Appointment_Canceled,
          Appointment_Added: Appointment_Added,
          Schedule: Schedule,
          Book_Appointment: Book_Appointment,
          Date: Date,
          Change: Change,
          Remind_Me: Remind_Me,
          Add_Appointment: Add_Appointment,
          Upcoming: Upcoming,
          Completed: Completed,
          Canceled: Canceled,
          Cancel: Cancel,
          Reschedule: Reschedule,
          Pending: Pending,
          Confirmed: Confirmed,
          ////  Feedback  Screen
          feeedback: feeedback,
          Provide_feedback: Provide_feedback,
          How_feedback_it_work: How_feedback_it_work,
          //// Message Screen

          Message: Message,
          Error_Try_Later: Error_Try_Later,
          Start_Chatting_With_Youer_Doctor: Start_Chatting_With_Youer_Doctor,
          All: All,
          Group: Group,
          Private: Private,

          //// Home Screen
          Find_your_desire_healt_solution: Find_your_desire_healt_solution,
          Search_doctor_drugs_articles: Search_doctor_drugs_articles,
          Doctors: Doctors,
          Pharmacy: Pharmacy,
          Hospital: Hospital,
          Ambulance: Ambulance,
          Top_Doctor: Top_Doctor,
          Early_protection_for_your_family_health:
              Early_protection_for_your_family_health,

          //////   Doctor Screen
          About: About,
          Booking: Booking,
          Doctor_Detail: Doctor_Detail,
          Doctorss: Doctorss,
          Find_doctor: Find_doctor,
          Category: Category,
          General: General,
          Lungs_Specialist: Lungs_Specialist,
          Dentist: Dentist,
          Psychiatrist: Psychiatrist,
          Surgeon: Surgeon,
          Cardiologist: Cardiologist,
          Covid: Covid,
          Popular_Product: Popular_Product,
          Favorite_Product: Favorite_Product,
          Search_drugs_category: Search_drugs_category,

          /// cart Screen
          My_Cart: My_Cart,
          Cart: Cart,
          History: History,
          XProduct: XProduct,
          Ongoing: Ongoing,
          Your_cart_is_Empty: Your_cart_is_Empty,
          Orders_Details: Orders_Details,
          You_should_at_least_add_an_item_in_the_cart:
              You_should_at_least_add_an_item_in_the_cart,
          Total: Total,
          Checkout: Checkout,
          Add_to_cart: Add_to_cart,
          Drugs_Item: Drugs_Item,
          Already_added_to_cart: Already_added_to_cart,
          add_to_cart: add_to_cart,
          /////  Drug Screen
          Strength: Strength,
          Generic_Name: Generic_Name,
          Dosage_Form: Dosage_Form,
          Route_of_Administration: Route_of_Administration,
          Pacakge_Size: Pacakge_Size,
          SFDA_Code: SFDA_Code,
          Medical_bulletin: Medical_bulletin,

          /// Chats Screen
          Loading: Loading,
          No_Match_Fond: No_Match_Fond,
          Type_message: Type_message,
          Say_Hi_You_can_consult_your_problem_to_the_doctor:
              Say_Hi_You_can_consult_your_problem_to_the_doctor,
          //// Notifications
          Notifications: Notifications,
          You_Have_Appointment_With: You_Have_Appointment_With,
          //// Location Screen
          Location: Location,
          LocationInfo: LocationInfo,
          Save_Address: Save_Address,
          You_have_not_selected_location: You_have_not_selected_location,
          Search_location_ZIP_code: Search_location_ZIP_code,
          Confirm_Location: Confirm_Location,
          Confirm_your_address: Confirm_your_address,
        },
      };
}
