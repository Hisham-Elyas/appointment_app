// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'doctor_model.dart';

class MessageHistoryInUser {
  final String? lastMessage;
  final String? receiverId;
  final String? receiverName;
  final Doctor? doctor;
  final Timestamp? timestamp;

  MessageHistoryInUser({
    this.lastMessage,
    this.receiverId,
    this.receiverName,
    this.doctor,
    this.timestamp,
  });

  MessageHistoryInUser copyWith({
    String? lastMessage,
    String? receiverId,
    String? receiverName,
    Doctor? doctor,
    Timestamp? timestamp,
  }) {
    return MessageHistoryInUser(
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
        other.doctor == doctor &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return lastMessage.hashCode ^
        receiverId.hashCode ^
        receiverName.hashCode ^
        doctor.hashCode ^
        timestamp.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastMessage': lastMessage,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'doctor': doctor?.toMap(),
      'timestamp': timestamp,
    };
  }

  String toJson() => json.encode(toMap());

  factory MessageHistoryInUser.fromJson(String source) =>
      MessageHistoryInUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
