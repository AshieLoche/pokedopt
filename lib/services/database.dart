import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pokedopt/models/user.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ this.uid });

  // Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String pfpUrl, String username, String age, String gender, String typePreference, String regionPreference) async {
    // String pfpUrl = await uploadPfpImage(imageFile);
    return await userCollection.doc(uid).set({
      'pfpUrl': pfpUrl,
      'username': username,
      'age': age,
      'gender': gender,
      'typePreference': typePreference,
      'regionPreference': regionPreference,
    });
  }

  Future uploadPfpImage(XFile imageFile) async {
    try {
      Reference storageRef = FirebaseStorage.instance.ref();
      Reference imageRef = storageRef.child('pfp_images/${imageFile.name}');
      UploadTask uploadTask = imageRef.putFile(File(imageFile.path));

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;  // This is the pfpUrl you'll store in Firestore
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return null;
    }
  }

  // Get User Data Stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

  // User Data from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> snap = snapshot.data() as Map<String, dynamic>;
    return UserData(
        uid: uid,
        pfpUrl: snap['pfpUrl'],
        username: snap['username'],
        age: snap['age'],
        gender:snap['gender'],
        typePreference: snap['typePreference'],
        regionPreference: snap['regionPreference']
    );
  }

  // // Profile Model from Snapshot
  // List<ProfileModel> _profileModelSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //     return ProfileModel(
  //       pfpUrl: data['pfpUrl'] ?? '',
  //       username: data['username'] ?? '',
  //       age: data['age'] ?? '',
  //       gender: data['gender'] ?? '',
  //       typePreference: data['typePreference'] ?? '',
  //       regionPreference: data['regionPreference'] ?? '',
  //     );
  //   }).toList();
  // }
  //
  // // Get Pokemon Stream
  // Stream<List<ProfileModel>> get profiles {
  //   return pokemonCollection.snapshots()
  //       .map(_profileModelSnapshot);
  // }

}