// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? id;
  final String? receiverId;
  final String? senderId;
  final String? message;
  final Timestamp? timestamp;
  final bool isSeen;

  MessageModel({
    this.id,
    this.receiverId,
    this.senderId,
    this.message,
    this.timestamp,
    required this.isSeen,
  });

  MessageModel copyWith({
    String? id,
    String? receiverId,
    String? senderId,
    String? message,
    Timestamp? timestamp,
    bool? isSeen,
  }) {
    return MessageModel(
      id: id ?? this.id,
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'receiverId': receiverId,
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp,
      'isSeen': isSeen,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] != null ? map['id'] as String : null,
      receiverId:
          map['receiverId'] != null ? map['receiverId'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      timestamp:
          map['timestamp'] != null ? map['timestamp'] as Timestamp : null,
      isSeen: map['isSeen'],
    );
  }

  @override
  String toString() {
    return 'MessageModel(id: $id, receiverId: $receiverId, senderId: $senderId, message: $message, timestamp: $timestamp, isSeen: $isSeen)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.receiverId == receiverId &&
        other.senderId == senderId &&
        other.message == message &&
        other.timestamp == timestamp &&
        other.isSeen == isSeen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        receiverId.hashCode ^
        senderId.hashCode ^
        message.hashCode ^
        timestamp.hashCode ^
        isSeen.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
