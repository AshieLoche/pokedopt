import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokedopt/models/pokemon.dart';
import 'dart:io';
import 'package:pokedopt/models/user.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ this.uid });

  // Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference pokemonCollection = FirebaseFirestore.instance.collection('pokemons');
  final CollectionReference favouriteCollection = FirebaseFirestore.instance.collection('favourites');

  Future updateUserData(String pfpUrl, String username, String age, String gender, String typePreferences, String regionPreferences, Timestamp createdAt) async {
    // String pfpUrl = await uploadPfpImage(imageFile);
    return await userCollection.doc(uid).set({
      'pfpUrl': pfpUrl,
      'username': username,
      'age': age,
      'gender': gender,
      'typePreferences': typePreferences,
      'regionPreferences': regionPreferences,
      'createdAt': createdAt,
    });
  }

  Future updateFavouriteData(String pokemonId, String pokemonName, bool isFavourited) async {
    // String pfpUrl = await uploadPfpImage(imageFile);
    return (isFavourited) ? await favouriteCollection.doc(uid).update({
      pokemonName: pokemonId,
    }) : await favouriteCollection.doc(uid).update({
      pokemonName: FieldValue.delete(),
    });
  }

  // Pokemon List from snapshot
  List<Pokemon> _pokemonListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Pokemon(
        id: doc.id,
        name: data['name'],
        species: data['species'],
        imageURL: data['imageURL'],
        description: data['description'],
        types: data['type/s'],
        region: data['region'],
      );
    }).toList();
  }

  // Get Pokemons Stream
  Stream<List<Pokemon>> get pokemons {
    return pokemonCollection.snapshots()
    .map(_pokemonListFromSnapshot);
  }

  List<FavouritePokemon> _favouriteFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return data.values.map((pokemonId) => FavouritePokemon(
        userId: doc.id,
        pokemonId: pokemonId,
      )).toList();
    }).toList().expand((element) => element).toList();
  }

  Stream<List<FavouritePokemon>> get favourites {
    return favouriteCollection.snapshots().map(_favouriteFromSnapshot);
  }

  // User Data from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> snap = snapshot.data() as Map<String, dynamic>;
    return UserData(
        uid: uid,
        pfpUrl: snap['pfpUrl'],
        username: snap['username'],
        age: snap['age'],
        gender: snap['gender'],
        typePreferences: snap['typePreferences'],
        regionPreferences: snap['regionPreferences'],
        createdAt: snap['createdAt'],
    );
  }

  // Get User Data Stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  // Retrieve Image From Database
  Future<String> getImageURL(String imagePath) async {

    final storage = FirebaseStorage.instanceFor(bucket: 'gs://pokedopt-c3b3f.appspot.com');

    final imageRef = storage.ref().child(imagePath);

    try {
      final url = await imageRef.getDownloadURL();
      return url;
    } catch (error) {
      print('Error retrieving image URL: $error');
      // Handle error (e.g., display an error message to the user)
      return ''; // Or a placeholder URL
    }

  }

  // Upload Image
  Future<String> uploadPfpImage(XFile imageFile, String uid) async {

    final storage = FirebaseStorage.instanceFor(bucket: 'gs://pokedopt-c3b3f.appspot.com');

    final imagePath = 'profilePics/$uid.${imageFile.name.split('.')[1]}';

    final imageRef = storage.ref().child(imagePath);

    try {

      UploadTask uploadTask = imageRef.putFile(File(imageFile.path));

      await uploadTask;

      return imagePath;

    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return '';
    }
  }

}