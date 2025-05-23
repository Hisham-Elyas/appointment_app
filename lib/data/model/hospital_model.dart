// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class HospitalModelList {
  final int count;
  final List<HospitalModel> hospitals;
  HospitalModelList({
    required this.count,
    required this.hospitals,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'hospitals': hospitals.map((x) => x.toMap()).toList(),
    };
  }

  factory HospitalModelList.fromMap(Map<String, dynamic> map) {
    return HospitalModelList(
      count: map['count'] as int,
      hospitals: List<HospitalModel>.from(
        (map['hospitals'] as List<dynamic>).map<HospitalModel>(
          (x) => HospitalModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HospitalModelList.fromJson(String source) =>
      HospitalModelList.fromMap(json.decode(source) as Map<String, dynamic>);

  HospitalModelList copyWith({
    int? count,
    List<HospitalModel>? hospitals,
  }) {
    return HospitalModelList(
      count: count ?? this.count,
      hospitals: hospitals ?? this.hospitals,
    );
  }

  @override
  String toString() =>
      'HospitalModelList(count: $count, hospitals: $hospitals)';

  @override
  bool operator ==(covariant HospitalModelList other) {
    if (identical(this, other)) return true;

    return other.count == count && listEquals(other.hospitals, hospitals);
  }

  @override
  int get hashCode => count.hashCode ^ hospitals.hashCode;
}

class HospitalModel {
  final String id;
  final String name;
  final String address;
  final String phoneNunber;
  final String img;

  HospitalModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNunber,
    required this.img,
  });

  HospitalModel copyWith({
    String? id,
    String? name,
    String? address,
    String? phoneNunber,
    String? img,
  }) {
    return HospitalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNunber: phoneNunber ?? this.phoneNunber,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phoneNunber': phoneNunber,
      'img': img,
    };
  }

  factory HospitalModel.fromMap(Map<String, dynamic> map) {
    return HospitalModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      phoneNunber: map['phoneNunber'] as String,
      img: map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HospitalModel.fromJson(String source) =>
      HospitalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HospitalModel(id: $id, name: $name, address: $address, phoneNunber: $phoneNunber, img: $img)';
  }

  @override
  bool operator ==(covariant HospitalModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.phoneNunber == phoneNunber &&
        other.img == img;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        phoneNunber.hashCode ^
        img.hashCode;
  }
}
