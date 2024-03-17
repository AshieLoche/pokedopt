import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection Reference
  final CollectionReference pokemonCollection =
  FirebaseFirestore.instance.collection('pokemons');

  Future<void> updateUserData(String userId, Map<String, dynamic> userData) async {
    try {
      await pokemonCollection.doc(userId).update(userData);
      print('User data updated successfully');
    } catch (error) {
      print('Failed to update user data: $error');
      throw error; // Rethrow the error to handle it in the calling code if necessary
    }
  }
}
