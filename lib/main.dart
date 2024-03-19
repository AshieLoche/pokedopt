import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedopt/models/user.dart';
import 'package:pokedopt/screens/main/pokelist.dart';
import 'package:pokedopt/screens/pokedoptScreen/pokedopt.dart';
import 'package:pokedopt/screens/main/profile.dart';
import 'package:pokedopt/screens/wrapper.dart';
import 'package:pokedopt/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCdbNrbP36X1apDPp2l8xjmwchS2xUhFdE",
      appId: "1:77226759639:android:39a64ed50cf6a8c7632792",
      messagingSenderId: "77226759639",
      projectId: "pokedopt-c3b3f",
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
          // '/PokeList': (context) => const PokeList(likedPokemons: [],), // Route for the cart page(PokeList)
          '/PokeDopt': (context) => const PokeDopt(likedPokemons: [],), // Route for the PokeDopt page
          '/PokeList': (context) => const PokeList(),
        },
      ),
    );
  }
}