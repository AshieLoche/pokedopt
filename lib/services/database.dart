import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // Collection Reference
  final CollectionReference pokemonCollection = FirebaseFirestore.instance.collection('pokemons');

  Future updateUserData(String pfp, String username, String age, String gender, String typePreference, String regionPreference) async {
    return await pokemonCollection.doc(uid).set({
      'pfp': pfp,
      'username': username,
      'age': age,
      'gender': gender,
      'type_preference': typePreference,
      'region_preference': regionPreference,
    });
  }

}