// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_errormessage.dart';
import '../dataSoureces/remoteDataSource/chats_remotdata.dart';
import '../model/doctor_model.dart';
import '../model/message_history_model.dart';
import '../model/message_model.dart';

abstract class ChatRepo {
  Future<bool> sendMessage({required Doctor doctor, required String message});
  Stream<List<MessageModel>> getMessage({required String contactId});
  Stream<List<MessageHistoryInUser>> getMessageHistory();
  Future<void> setSeenMessage(
      {required Doctor doctor, required MessageModel msg});
}

class ChatRepoImpFirebase implements ChatRepo {
  final ChatRemotDataImpFirebase chatRemotData;
  ChatRepoImpFirebase({
    required this.chatRemotData,
  });
  @override

  /// Retrieves a stream of [MessageModel] objects for a given [contactId].
  ///
  /// The [contactId] parameter is required and specifies the ID of the contact for
  /// which to retrieve the messages.
  ///
  /// Returns a [Stream] of [List<MessageModel>] that emits a list of messages
  /// associated with the specified contact.
  Stream<List<MessageModel>> getMessage({required String contactId}) {
    return chatRemotData.getMessage(contactId: contactId);
  }

  @override
  Stream<List<MessageHistoryInUser>> getMessageHistory() {
    return chatRemotData.getMessageHistory();
  }

  @override
  Future<bool> sendMessage(
      {required Doctor doctor, required String message}) async {
    if (await ckeckInternet()) {
      return chatRemotData.sendMessage2(doctor: doctor, message: message);
    } else {
      showNetworkError();

      return false;
    }
  }

  @override
  Future<void> setSeenMessage(
      {required Doctor doctor, required MessageModel msg}) {
    return chatRemotData.setSeenMessage(doctor: doctor, msg: msg);
  }
}
