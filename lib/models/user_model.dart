import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  final String id;

  final String name;

  final String surname;

  final String email;

  final bool isOnboardingCompleted;

  final String profilePictureUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Usermodel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.isOnboardingCompleted,
    required this.profilePictureUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  //FOR CONVERTING THE INCOMİNG JSON/FIRESSTORE DATA TO USERMODEL
  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'] as String,
      name: json['name'] as String,

      surname: json['surname'] as String,
      email: json['email'] as String,
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool,
      profilePictureUrl: json['profilePictureUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  //FOR CONVERTING THE USERMODEL TO JSON/FIRESTORE DATA
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "email": email,
      "isOnboardingCompleted": isOnboardingCompleted,
      "profilePictureUrl": profilePictureUrl,

      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
