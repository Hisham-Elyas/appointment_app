import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../core/functions/make_phone_call.dart';
import '../data/model/ambulance_model.dart';
import '../data/repositories/Ambulance_repo.dart';

class AmbulanceController extends GetxController {
  final AmbulanceRepoImpHttp ambulanceRepo = Get.find();
  late StatusRequest statusReq;
  List<AmbulanceModel> hospitalList = [];
  @override
  void onInit() async {
    super.onInit();
    await getAllAmbulance();
  }

  Future<void> getAllAmbulance() async {
    statusReq = StatusRequest.loading;
    update();
    final data = await ambulanceRepo.getAllAmbulance();
    data.fold((l) {
      statusReq = l;

      update();
    }, (r) {
      /////
      hospitalList.clear();
      hospitalList.addAll(r.ambulances);

      statusReq = StatusRequest.success;

      update();
    });
  }

  Future<void> makePhoneCall({required String phoneNum}) async {
    await makePhoneCallLaunch(phoneNum);
  }
}
