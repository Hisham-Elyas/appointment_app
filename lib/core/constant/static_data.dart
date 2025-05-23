import 'package:get/get.dart';

import '../../data/model/category_model.dart';
import '../../data/model/on_boarding_model.dart';
import 'image_asset.dart';
import 'string.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      img: ImageAssetPNG.onBoardingImg1,
      discription: Consult_only_with_a_doctor_you_trust.tr),
  OnBoardingModel(
      img: ImageAssetPNG.onBoardingImg2,
      discription: Find_a_lot_of_specialist_doctors_in_one_place.tr),
  OnBoardingModel(
      img: ImageAssetPNG.onBoardingImg3,
      discription: Get_connect_our_Online_Consultation.tr),
];

List<CategoryModel> categoryHomeList = [
  CategoryModel(img: ImageAssetSVG.doctorLogo, name: Doctors),
  // CategoryModel(img: ImageAssetSVG.pharmacyLogo, name: Pharmacy),
  // CategoryModel(img: ImageAssetSVG.hospitalLogo, name: Hospital),
  // CategoryModel(img: ImageAssetSVG.ambulanceLogo, name: Ambulance),
];

List<CategoryModel> categoryDoctorList = [
  CategoryModel(img: ImageAssetSVG.doctorLogo, name: General),
  CategoryModel(img: ImageAssetSVG.lungsIcon, name: Lungs_Specialist),
  CategoryModel(img: ImageAssetSVG.dentistIcon, name: Dentist),
  CategoryModel(img: ImageAssetSVG.psychiatristIcon, name: Psychiatrist),
  CategoryModel(img: ImageAssetSVG.syringeIcon, name: Surgeon),
  CategoryModel(img: ImageAssetSVG.cardiologistIcon, name: Cardiologist),
  CategoryModel(img: ImageAssetSVG.covidIcon, name: Covid),
];
