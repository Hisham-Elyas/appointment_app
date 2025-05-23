// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/constant/string.dart';
import 'location_model.dart';
import 'user_model.dart';

enum Status {
  pending(pendingEnum),
  underway(underwayEnum),
  delivered(deliveredEnum),
  closed(closedEnum),
  cancel(cancelEnum);

  const Status(this.type);
  final String type;
}

extension ConvertStatus on String {
  Status toEnum() {
    switch (this) {
      case pendingEnum:
        return Status.pending;
      case underwayEnum:
        return Status.underway;
      case deliveredEnum:
        return Status.delivered;
      case cancelEnum:
        return Status.cancel;
      case closedEnum:
        return Status.closed;

      default:
        return Status.pending;
    }
  }
}

class OrderListModel {
  final int? count;
  final List<OrderModel> producus;

  OrderListModel({this.count, required this.producus});

  factory OrderListModel.fromMap(Map<String, dynamic> map) {
    return OrderListModel(
      count: map['count'] != null ? map['count'] as int : null,
      producus: List<OrderModel>.from(
        (map['producus'] as List<dynamic>).map<OrderModel>(
          (x) => OrderModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory OrderListModel.fromJson(String source) =>
      OrderListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderModel {
  final String? id;
  final String? userId;
  final UserModel userInfo;
  final LocationModel userLocation;
  final List<String?> listProduct;
  final Status? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderModel({
    this.id,
    this.userId,
    required this.userInfo,
    required this.userLocation,
    required this.listProduct,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  OrderModel copyWith({
    String? id,
    String? userId,
    UserModel? userInfo,
    LocationModel? userLocation,
    List<String?>? listProduct,
    Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userInfo: userInfo ?? this.userInfo,
      userLocation: userLocation ?? this.userLocation,
      listProduct: listProduct ?? this.listProduct,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'userInfo': userInfo.toMap(),
      'userLocation': userLocation.toMap(),
      'listProduct': listProduct,
      'status': status?.type,
      'createdAt': createdAt?.toString(),
      'updatedAt': updatedAt?.toString(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      userInfo: UserModel.fromMap(map['userInfo'] as Map<String, dynamic>),
      userLocation:
          LocationModel.fromMap(map['userLocation'] as Map<String, dynamic>),
      listProduct: List<String?>.from((map['listProduct'] as List<dynamic>)),
      status: map['status'] != null
          ? (map['status'] as String).toEnum()
          : Status.pending,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, userId: $userId, userInfo: $userInfo, userLocation: $userLocation, listProduct: $listProduct, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.userInfo == userInfo &&
        other.userLocation == userLocation &&
        listEquals(other.listProduct, listProduct) &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        userInfo.hashCode ^
        userLocation.hashCode ^
        listProduct.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
