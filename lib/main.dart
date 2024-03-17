import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedopt/models/user.dart';
import 'package:pokedopt/screens/main/pokelist.dart';
import 'package:pokedopt/screens/main/pokedopt.dart';
import 'package:pokedopt/screens/main/profile.dart';
import 'package:pokedopt/screens/wrapper.dart';
import 'package:pokedopt/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAGxQhNtp3k_kZAn5oa1Cq0BZnd2oqahis",
      appId: "1:78145003192:android:1c4b7557237ae34d0a9e4d",
      messagingSenderId: "78145003192",
      projectId: "brew-crew-fcf38",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokeDopt',
        theme: ThemeData.dark(), // Set the theme to dark mode
        routes: {
          '/': (context) => const Wrapper(), // Route for the main page
          '/Profile': (context) => const Profile(), // Route for the profile page
          '/PokeList': (context) => const PokeList(), // Route for the cart page(PokeList)
          '/PokeDopt': (context) => const PokeDopt(likedPokemons: [],), // Route for the PokeDopt page
        },
      ),
    );
  }
}