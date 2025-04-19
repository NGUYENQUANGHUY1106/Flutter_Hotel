import 'dart:convert';

class UserModel {
  String? email;
  String? password;

  UserModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'UserModel(email: $email, password: $password)';

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
