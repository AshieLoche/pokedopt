import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // Collection Reference
  final CollectionReference pokemonCollection = FirebaseFirestore.instance.collection('pokemons');

  Future updateUserData()

}