import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedopt/services/database.dart';

import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/foundation.dart';

class AuthService {

  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  // Create user obj based on FirebaseUser
  User? _userFromFirebaseUser(firebase.User? user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth Change User Stream
  Stream<User?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  // Sign in anon
  Future signInAnon() async {
    try {
      firebase.UserCredential result = await _auth.signInAnonymously();
      firebase.User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async
  {
    try {
      firebase.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebase.User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      firebase.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebase.User? user = result.user;

      // Call updateUserData with userId and userData Map
      await DatabaseService().updateUserData('0', 'Ash Ketchum', '21', 'Male', 'Ghost', 'Kalos', Timestamp.now());

      return _userFromFirebaseUser(user);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return e.toString();
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      if (kDebugMode) {
        print(e.toString());
        return null;
      }
    }
  }

}