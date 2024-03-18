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
  final String typePreference;
  final String regionPreference;

  UserData({required this.uid, required this.pfpUrl, required this.username, required this.age, required this.gender, required this.typePreference, required this.regionPreference});

}