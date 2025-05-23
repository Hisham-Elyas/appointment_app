import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../core/functions/make_phone_call.dart';
import '../data/model/hospital_model.dart';
import '../data/repositories/hospital_repo.dart';

class HospitalsController extends GetxController {
  final HospitalRepoImpHttp hospitalRepo = Get.find();
  late StatusRequest statusReq;
  List<HospitalModel> hospitalList = [];
  @override
  void onInit() async {
    super.onInit();
    await getAllHospital();
  }

  Future<void> getAllHospital() async {
    statusReq = StatusRequest.loading;
    update();
    final data = await hospitalRepo.getAllHospital();
    data.fold((l) {
      statusReq = l;

      update();
    }, (r) {
      /////
      hospitalList.clear();
      hospitalList.addAll(r.hospitals);

      statusReq = StatusRequest.success;

      update();
    });
  }

  Future<void> makePhoneCall({required String phoneNum}) async {
    await makePhoneCallLaunch(phoneNum);
  }
}
