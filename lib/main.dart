import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedopt/models/user.dart';
import 'package:pokedopt/screens/pokehomeScreen/pokehome.dart';
import 'package:pokedopt/screens/pokelistScreen/pokelist.dart';
import 'package:pokedopt/screens/profileScreen/profile.dart';
import 'package:pokedopt/screens/miscellaneous/wrapper.dart';
import 'package:pokedopt/services/authService.dart';
import 'package:provider/provider.dart';

// Initializes the App
void main() async {
  // Ensures that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes the Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCdbNrbP36X1apDPp2l8xjmwchS2xUhFdE",
      appId: "1:77226759639:android:39a64ed50cf6a8c7632792",
      messagingSenderId: "77226759639",
      projectId: "pokedopt-c3b3f",
    ),
  );

  // Runs the App
  runApp(const PokeDopt());
}

// Main Class for Pokedopt
class PokeDopt extends StatelessWidget {
  const PokeDopt({super.key});

  @override
  Widget build(BuildContext context) {
    // Provides the User Uid
    return StreamProvider<User?>.value(
      // Create a Firebase User
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        // Removes the Debug Banner
        debugShowCheckedModeBanner: false,
        // App Title
        title: 'PokeDopt',
        // Set the theme to dark mode
        theme: ThemeData.dark(),
        // Routes to Various Pages
        routes: {
          // Route for the Wrapper page
          '/': (context) => const Wrapper(),
          // Route for the Profile page
          '/Profile': (context) => const Profile(),
          // Route for the PokeList page
          '/PokeList': (context) => const PokeList(),
          // Route for the PokeHome page
          '/PokeHome': (context) => const PokeHome(),
        },
      ),
    );
  }
}