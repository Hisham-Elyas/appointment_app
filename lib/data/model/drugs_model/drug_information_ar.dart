// ignore_for_file: public_member_api_docs, sort_constructors_first
class DrugInformationAr {
  String? tradeName;
  String? strength;
  String? genericName;
  String? dosageForm;
  String? routeOfAdministration;
  String? sfdaCode;
  String? pacakgeSize;

  DrugInformationAr({
    this.tradeName,
    this.strength,
    this.genericName,
    this.dosageForm,
    this.routeOfAdministration,
    this.sfdaCode,
    this.pacakgeSize,
  });

  factory DrugInformationAr.fromJson(Map<String, dynamic> json) {
    return DrugInformationAr(
      tradeName: json['Trade Name'] as String?,
      strength: json['Strength'] as String?,
      genericName: json['Generic Name'] as String?,
      dosageForm: json['Dosage Form'] as String?,
      routeOfAdministration: json['Route of Administration'] as String?,
      sfdaCode: json['SFDA Code'] as String?,
      pacakgeSize: json['Pacakge Size'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'Trade Name': tradeName,
        'Strength': strength,
        'Generic Name': genericName,
        'Dosage Form': dosageForm,
        'Route of Administration': routeOfAdministration,
        'SFDA Code': sfdaCode,
        'Pacakge Size': pacakgeSize,
      };

  @override
  bool operator ==(covariant DrugInformationAr other) {
    if (identical(this, other)) return true;

    return other.tradeName == tradeName &&
        other.strength == strength &&
        other.genericName == genericName &&
        other.dosageForm == dosageForm &&
        other.routeOfAdministration == routeOfAdministration &&
        other.sfdaCode == sfdaCode &&
        other.pacakgeSize == pacakgeSize;
  }

  @override
  int get hashCode {
    return tradeName.hashCode ^
        strength.hashCode ^
        genericName.hashCode ^
        dosageForm.hashCode ^
        routeOfAdministration.hashCode ^
        sfdaCode.hashCode ^
        pacakgeSize.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tradeName': tradeName,
      'strength': strength,
      'genericName': genericName,
      'dosageForm': dosageForm,
      'routeOfAdministration': routeOfAdministration,
      'sfdaCode': sfdaCode,
      'pacakgeSize': pacakgeSize,
    };
  }

  factory DrugInformationAr.fromMap(Map<String, dynamic> map) {
    return DrugInformationAr(
      tradeName: map['tradeName'] != null ? map['tradeName'] as String : null,
      strength: map['strength'] != null ? map['strength'] as String : null,
      genericName:
          map['genericName'] != null ? map['genericName'] as String : null,
      dosageForm:
          map['dosageForm'] != null ? map['dosageForm'] as String : null,
      routeOfAdministration: map['routeOfAdministration'] != null
          ? map['routeOfAdministration'] as String
          : null,
      sfdaCode: map['sfdaCode'] != null ? map['sfdaCode'] as String : null,
      pacakgeSize:
          map['pacakgeSize'] != null ? map['pacakgeSize'] as String : null,
    );
  }

  @override
  String toString() {
    return 'DrugInformationAr(tradeName: $tradeName, strength: $strength, genericName: $genericName, dosageForm: $dosageForm, routeOfAdministration: $routeOfAdministration, sfdaCode: $sfdaCode, pacakgeSize: $pacakgeSize)';
  }
}
