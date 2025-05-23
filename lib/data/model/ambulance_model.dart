// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AmbulanceModelList {
  final int count;
  final List<AmbulanceModel> ambulances;

  AmbulanceModelList({
    required this.count,
    required this.ambulances,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'ambulances': ambulances.map((x) => x.toMap()).toList(),
    };
  }

  factory AmbulanceModelList.fromMap(Map<String, dynamic> map) {
    return AmbulanceModelList(
      count: map['count'] as int,
      ambulances: List<AmbulanceModel>.from(
        (map['ambulances'] as List<dynamic>).map<AmbulanceModel>(
          (x) => AmbulanceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AmbulanceModelList.fromJson(String source) =>
      AmbulanceModelList.fromMap(json.decode(source) as Map<String, dynamic>);

  AmbulanceModelList copyWith({
    int? count,
    List<AmbulanceModel>? ambulances,
  }) {
    return AmbulanceModelList(
      count: count ?? this.count,
      ambulances: ambulances ?? this.ambulances,
    );
  }

  @override
  String toString() =>
      'AmbulanceModelList(count: $count, ambulances: $ambulances)';

  @override
  bool operator ==(covariant AmbulanceModelList other) {
    if (identical(this, other)) return true;

    return other.count == count && listEquals(other.ambulances, ambulances);
  }

  @override
  int get hashCode => count.hashCode ^ ambulances.hashCode;
}

class AmbulanceModel {
  final String id;
  final String name;
  final String address;
  final String phoneNunber;
  final String img;
  AmbulanceModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNunber,
    required this.img,
  });

  AmbulanceModel copyWith({
    String? id,
    String? name,
    String? address,
    String? phoneNunber,
    String? img,
  }) {
    return AmbulanceModel(
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

  factory AmbulanceModel.fromMap(Map<String, dynamic> map) {
    return AmbulanceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      phoneNunber: map['phoneNunber'] as String,
      img: map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmbulanceModel.fromJson(String source) =>
      AmbulanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AmbulanceModel(id: $id, name: $name, address: $address, phoneNunber: $phoneNunber, img: $img)';
  }

  @override
  bool operator ==(covariant AmbulanceModel other) {
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
