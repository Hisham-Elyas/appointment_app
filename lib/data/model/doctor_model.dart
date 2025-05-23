// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DoctorModel {
  final int count;
  final List<Doctor> doctor;
  DoctorModel({
    required this.count,
    required this.doctor,
  });

  DoctorModel copyWith({
    int? count,
    List<Doctor>? doctor,
  }) {
    return DoctorModel(
      count: count ?? this.count,
      doctor: doctor ?? this.doctor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'doctor': doctor.map((x) => x.toMap()).toList(),
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      count: map['count'] as int,
      doctor: List<Doctor>.from(
        (map['doctor'] as List<dynamic>).map<Doctor>(
          (x) => Doctor.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DoctorModel(count: $count, doctor: $doctor)';

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return other.count == count && listEquals(other.doctor, doctor);
  }

  @override
  int get hashCode => count.hashCode ^ doctor.hashCode;
}

class Doctor {
  final String? id;
  final String? name;
  final String? address;
  final String? specialty;
  final String? email;
  final int? phoneNunber;
  final String? hoursOfOperation;
  final String? description;
  final String? img;
  final String? createdAt;
  final String? updatedAt;
  Doctor({
    this.id,
    this.name,
    this.address,
    this.specialty,
    this.email,
    this.phoneNunber,
    this.hoursOfOperation,
    this.description,
    this.img,
    this.createdAt,
    this.updatedAt,
  });

  Doctor copyWith({
    String? id,
    String? name,
    String? address,
    String? specialty,
    String? email,
    int? phoneNunber,
    String? hoursOfOperation,
    String? description,
    String? img,
    String? createdAt,
    String? updatedAt,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      specialty: specialty ?? this.specialty,
      email: email ?? this.email,
      phoneNunber: phoneNunber ?? this.phoneNunber,
      hoursOfOperation: hoursOfOperation ?? this.hoursOfOperation,
      description: description ?? this.description,
      img: img ?? this.img,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'specialty': specialty,
      'email': email,
      'phoneNunber': phoneNunber,
      'hoursOfOperation': hoursOfOperation,
      'description': description,
      'img': img,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] != null ? map['id'] as String : map['_id'] as String,
      // id: map['id'] != null ? map['id'] as String :      null,
      name: map['name'] != null ? map['name'] as String : '',
      address: map['address'] != null ? map['address'] as String : '',
      specialty: map['specialty'] != null ? map['specialty'] as String : '',
      email: map['email'] != null ? map['email'] as String : '',
      phoneNunber: map['phoneNunber'] != null ? map['phoneNunber'] as int : 0,
      hoursOfOperation: map['hoursOfOperation'] != null
          ? map['hoursOfOperation'] as String
          : '',
      description:
          map['description'] != null ? map['description'] as String : '',
      img: map['img'] != null ? map['img'] as String : '',
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : '',
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) =>
      Doctor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Doctor(id: $id, name: $name, address: $address, specialty: $specialty, email: $email, phoneNunber: $phoneNunber, hoursOfOperation: $hoursOfOperation, description: $description, img: $img, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Doctor other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.specialty == specialty &&
        other.email == email &&
        other.phoneNunber == phoneNunber &&
        other.hoursOfOperation == hoursOfOperation &&
        other.description == description &&
        other.img == img &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        specialty.hashCode ^
        email.hashCode ^
        phoneNunber.hashCode ^
        hoursOfOperation.hashCode ^
        description.hashCode ^
        img.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
