import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/constant/string.dart';
import '../data/model/doctor_model.dart';
import '../data/model/message_history_model.dart';
import '../data/model/message_model.dart';
import '../data/repositories/chats_repo.dart';

class ChatsController extends GetxController with WidgetsBindingObserver {
  final ChatRepoImpFirebase chatRepo = Get.find();
  final ScrollController scrollController = ScrollController();

  String massages = "";
  final List<String> taps = [
    All,
    // Group,
    // Private,
  ];
  int tapLIstNum = 0;

  set setTapLIstNum(val) {
    tapLIstNum = val;
    update();
  }

///////////// traking user states
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        printInfo(info: "=========== user is online");
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        printInfo(info: "=========== user is offline");

        break;
      default:
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  final TextEditingController textEditingCont = TextEditingController();

  setMassages(String value) {
    massages = value;
    update();
  }

  bool isSending = false;
  sendMassages({required Doctor doctor}) async {
    isSending = true;
    update();
    final bool isSucss =
        await chatRepo.sendMessage(doctor: doctor, message: massages);

    if (isSucss) {
      textEditingCont.clear();
      massages = '';
      update();
    }
    isSending = false;
    update();
  }

  Future<void> setSeenMessage(
      {required Doctor doctor, required MessageModel msg}) async {
    final String userId = chatRepo.chatRemotData.userId;
    if (userId == msg.receiverId && !msg.isSeen) {
      await chatRepo.setSeenMessage(doctor: doctor, msg: msg);
    } else {
      return;
    }
  }

  Stream<List<MessageModel>> getMessage({required String contactId}) {
    return chatRepo.getMessage(contactId: contactId);
  }

  Stream<List<MessageHistoryInUser>> getMessageHistory() {
    return chatRepo.getMessageHistory();
  }
}
