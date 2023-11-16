import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String name;
  String email;
  String cabang;
  String uId;
  UserModel({
    required this.name,
    required this.email,
    required this.cabang,
    required this.uId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'cabang': cabang,
      'uId': uId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      cabang: map['cabang'] ?? '',
      uId: map['uId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

      static UserModel? fromFirebaseUser(User user){}
}