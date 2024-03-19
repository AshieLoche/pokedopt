import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String uid;

  User ({required this.uid});

}

class UserData {

  final String? uid;
  final String pfpUrl;
  final String username;
  final String age;
  final String gender;
  final String typePreferences;
  final String regionPreferences;
  final Timestamp createdAt;

  UserData({required this.uid, required this.pfpUrl, required this.username, required this.age, required this.gender, required this.typePreferences, required this.regionPreferences, required this.createdAt});

}