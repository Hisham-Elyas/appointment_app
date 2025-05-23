// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? userId;
  final String? userName;
  final String email;
  final String? phone;

  final String? password;

  UserModel({
    this.userId,
    this.userName,
    required this.email,
    this.phone,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'email': email,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      email: map['email'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.userName == userName &&
        other.email == email &&
        other.phone == phone &&
        other.password == password;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        password.hashCode;
  }

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, email: $email, phone: $phone, password: $password)';
  }

  UserModel copyWith({
    String? userId,
    String? userName,
    String? email,
    String? phone,
    String? password,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}
