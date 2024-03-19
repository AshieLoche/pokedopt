import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokedopt/models/user.dart';
import 'package:pokedopt/screens/profileScreen/profileForm.dart';
import 'package:pokedopt/services/database.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../shared/loading.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {

  late Future<String> imageUrl;
  String username = '';
  String age = '';
  String gender = '';
  String typePreferences = '';
  String regionPreferences = '';

  void _navigateToEditProfileScreen() async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileForm(
          currentPfpUrl: imageUrl,
          currentUsername: username,
          currentAge: age,
          currentGender: gender,
          currentTypePreferences: typePreferences,
          currentRegionPreferences: regionPreferences,
        ),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        username = updatedProfile['username'];
        age = updatedProfile['age'];
        gender = updatedProfile['gender'];
        typePreferences = updatedProfile['typePreferences'];
        regionPreferences = updatedProfile['regionPreferences'];
        // Update other fields similarly
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          imageUrl = DatabaseService().getImageURL(userData!.pfpUrl);
          username = userData.username;
          age = userData.age;
          gender = userData.gender;
          typePreferences = userData.typePreferences;
          regionPreferences = userData.regionPreferences;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    FutureBuilder<String>(
                      future: imageUrl,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(snapshot.data!),
                          );
                        } else if (snapshot.hasError) {
                          return const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('assets/defaultPfp.png'),
                          );
                        }
                        // Display a progress indicator or placeholder while loading
                        return const CircleAvatar(
                          radius: 60,
                          child: Loading(),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 220,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _navigateToEditProfileScreen();
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildProfileField(label: 'Age', value: age),
                      _buildProfileField(label: 'Gender', value: gender),
                      _buildProfileField(label: 'Type Preference/s', value: typePreferences),
                      _buildProfileField(label: 'Region Preference/s', value: regionPreferences),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: const Center(
              child: Loading(),
            ),
          );
        }
      }
    );
  }
}

Widget _buildProfileField({required String label, required String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: ListTile(
      title: Text(label),
      subtitle: Text(value),
    ),
  );
}