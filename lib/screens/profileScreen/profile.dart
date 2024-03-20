import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokedopt/screens/profileScreen/profileData.dart';
import 'package:pokedopt/services/auth.dart';
import 'package:pokedopt/services/database.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () async {
                Navigator.of(context).popUntil((route) => route.isFirst);
                await _auth.signOut();
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ),
        ],
      ),
      body: const ProfileData(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.orange),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/pokedopt.ico'),color: Colors.orange,),
            label: 'PokeDopt',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              // Navigate to Profile page
              Navigator.pushNamed(context, '/Profile');
              break;
            case 1:
              // Handle PokeHome icon tap
              Navigator.pushNamed(context, '/PokeDopt');
              break;
            case 2:
              // Handle PokeList icon tap
              Navigator.pushNamed(context, '/PokeList');
              break;
          }
        },
      ),
    );
  }
}