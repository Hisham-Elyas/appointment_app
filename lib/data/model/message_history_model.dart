// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuer_city/data/model/doctor_model.dart';

class MessageHistoryInUser {
  final String? lastMessage;
  final String? receiverId;
  final String? receiverName;
  final String? senderName;
  final String? senderId;
  final Doctor? doctor;
  final Timestamp? timestamp;

  MessageHistoryInUser({
    required this.senderName,
    required this.senderId,
    this.lastMessage,
    this.receiverId,
    this.receiverName,
    this.doctor,
    this.timestamp,
  });

  MessageHistoryInUser copyWith({
    String? lastMessage,
    String? receiverId,
    String? senderId,
    String? receiverName,
    String? senderName,
    Doctor? doctor,
    Timestamp? timestamp,
  }) {
    return MessageHistoryInUser(
      senderName: senderName ?? senderName,
      senderId: senderId ?? senderId,
      lastMessage: lastMessage ?? this.lastMessage,
      receiverId: receiverId ?? this.receiverId,
      receiverName: receiverName ?? this.receiverName,
      doctor: doctor ?? this.doctor,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory MessageHistoryInUser.fromMap(Map<String, dynamic> map) {
    return MessageHistoryInUser(
      lastMessage:
          map['lastMessage'] != null ? map['lastMessage'] as String : null,
      receiverId:
          map['receiverId'] != null ? map['receiverId'] as String : null,
      receiverName:
          map['receiverName'] != null ? map['receiverName'] as String : null,
      senderName:
          map['senderName'] != null ? map['senderName'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      doctor: map['doctor'] != null
          ? Doctor.fromMap(map['doctor'] as Map<String, dynamic>)
          : null,
      timestamp:
          map['timestamp'] != null ? map['timestamp'] as Timestamp : null,
    );
  }

  @override
  String toString() {
    return 'MessageHistoryInUser(lastMessage: $lastMessage, receiverId: $receiverId, receiverName: $receiverName, doctor: $doctor, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant MessageHistoryInUser other) {
    if (identical(this, other)) return true;

    return other.lastMessage == lastMessage &&
        other.receiverId == receiverId &&
        other.receiverName == receiverName &&
        other.senderId == senderId &&
        other.senderName == senderName &&
        other.doctor == doctor &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return lastMessage.hashCode ^
        receiverId.hashCode ^
        receiverName.hashCode ^
        senderName.hashCode ^
        senderId.hashCode ^
        doctor.hashCode ^
        timestamp.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastMessage': lastMessage,
      'receiverId': receiverId,
      'senderId': senderId,
      'receiverName': receiverName,
      'senderName': senderName,
      'doctor': doctor?.toMap(),
      'timestamp': timestamp,
    };
  }

  String toJson() => json.encode(toMap());

  factory MessageHistoryInUser.fromJson(String source) =>
      MessageHistoryInUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
