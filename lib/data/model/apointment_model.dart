// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'doctor_model.dart';

class AppointmentModel {
  final int count;
  final List<Appointment> appointment;
  AppointmentModel({
    required this.count,
    required this.appointment,
  });

  AppointmentModel copyWith({
    int? count,
    List<Appointment>? appointment,
  }) {
    return AppointmentModel(
      count: count ?? this.count,
      appointment: appointment ?? this.appointment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'appointment': appointment.map((x) => x.toMap()).toList(),
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      count: map['count'] as int,
      appointment: List<Appointment>.from(
        (map['appointment'] as List<dynamic>).map<Appointment>(
          (x) => Appointment.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppointmentModel(count: $count, appointment: $appointment)';

  @override
  bool operator ==(covariant AppointmentModel other) {
    if (identical(this, other)) return true;

    return other.count == count && listEquals(other.appointment, appointment);
  }

  @override
  int get hashCode => count.hashCode ^ appointment.hashCode;
}

class Appointment {
  final String? id;
  final String name;
  final String userId;
  final String doctorId;
  final DateTime? bookDate;
  final DateTime? createdAt;
  final bool? isCompleted;
  final bool? isConfirmed;
  final DateTime? updatedAt;
  final Doctor doctor;

  Appointment({
    this.id,
    required this.name,
    required this.userId,
    required this.doctorId,
    required this.bookDate,
    this.isConfirmed,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
    required this.doctor,
  });

  Appointment copyWith({
    String? id,
    String? name,
    String? userId,
    String? doctorId,
    DateTime? bookDate,
    DateTime? createdAt,
    bool? isCompleted,
    bool? isConfirmed,
    DateTime? updatedAt,
    Doctor? doctor,
  }) {
    return Appointment(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      bookDate: bookDate ?? this.bookDate,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      updatedAt: updatedAt ?? this.updatedAt,
      doctor: doctor ?? this.doctor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'doctorId': doctorId,
      'bookDate': bookDate != null ? Timestamp.fromDate(bookDate!) : null,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'isCompleted': isCompleted,
      'isConfirmed': isConfirmed,
      'doctor': doctor.toMap(),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map, {String? id}) {
    print(id);
    return Appointment(
      id: id,
      name: map['name'] ?? '',
      userId: map['userId'] ?? '',
      doctorId: map['doctorId'] ?? '',
      bookDate: (map['bookDate'] as Timestamp?)?.toDate(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
      isCompleted: map['isCompleted'] ?? false,
      isConfirmed: map['isConfirmed'] ?? false,
      doctor: Doctor.fromMap(Map<String, dynamic>.from(map['doctor'] ?? {})),
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source, {String? id}) =>
      Appointment.fromMap(json.decode(source), id: id);

  @override
  String toString() {
    return 'Appointment(id: $id, name: $name, userId: $userId, doctorId: $doctorId, bookDate: $bookDate, createdAt: $createdAt, isCompleted: $isCompleted, isConfirmed: $isConfirmed, updatedAt: $updatedAt, doctor: $doctor)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Appointment &&
          id == other.id &&
          name == other.name &&
          userId == other.userId &&
          doctorId == other.doctorId &&
          bookDate == other.bookDate &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          isCompleted == other.isCompleted &&
          isConfirmed == other.isConfirmed &&
          doctor == other.doctor;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      userId.hashCode ^
      doctorId.hashCode ^
      bookDate.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      isCompleted.hashCode ^
      isConfirmed.hashCode ^
      doctor.hashCode;
}
