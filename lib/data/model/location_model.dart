import 'dart:convert';

class LocationModel {
  final String addressType;
  final String address;
  final double longitude;
  final double latitude;
  LocationModel({
    required this.addressType,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  LocationModel copyWith({
    int? id,
    String? addressType,
    String? address,
    double? longitude,
    double? latitude,
  }) {
    return LocationModel(
      addressType: addressType ?? this.addressType,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressType': addressType,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      addressType: map['addressType'] as String,
      address: map['address'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel( addressType: $addressType, address: $address, longitude: $longitude, latitude: $latitude)';
  }

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.addressType == addressType &&
        other.address == address &&
        other.longitude == longitude &&
        other.latitude == latitude;
  }

  @override
  int get hashCode {
    return addressType.hashCode ^
        address.hashCode ^
        longitude.hashCode ^
        latitude.hashCode;
  }
}
