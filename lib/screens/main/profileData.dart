import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedopt/models/user.dart';
import 'package:pokedopt/services/database.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  String username = '';
  String age = '';
  String gender = 'Male';
  String typePreferences = '';
  String regionPreferences = '';

  void _navigateToEditProfileScreen() async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          initialUsername: username,
          initialAge: age,
          initialGender: gender,
          initialTypePreferences: typePreferences,
          initialRegionPreferences: regionPreferences,
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

    // final profiles = Provider.of<List<ProfileModel>?>(context);

    // if (profiles != null) {
    //   for (var profile in profiles) {
    //     print(profile.pfpUrl);
    //     print(profile.username);
    //     print(profile.age );
    //     print(profile.gender);
    //     print(profile.typePreference);
    //     print(profile.regionPreference);
    //   }
    // }



    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/asheprofile.png'),
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

class EditProfileScreen extends StatefulWidget {
  final String initialUsername;
  final String initialAge;
  final String initialGender;
  final String initialTypePreferences;
  final String initialRegionPreferences;

  const EditProfileScreen({
    super.key,
    required this.initialUsername,
    required this.initialAge,
    required this.initialGender,
    required this.initialTypePreferences,
    required this.initialRegionPreferences,
  });

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _ageController;
  late String _gender;
  late List<String> _typePreferences;
  late List<String> _regionPreferences;

  final List<String> genders = ['Male', 'Female', 'Non-Binary'];
  final List<String> types = ['Fire', 'Water', 'Grass', 'Electric', 'Ghost', 'Steel', 'Ground', 'Rock', 'Fairy', 'Dragon', 'Poison', 'Dark', 'Psychic', 'Bug', 'Fighting', 'Normal', 'Flying', 'Ice'];
  final List<String> regions = ['Kanto', 'Johto', 'Hoenn', 'Sinnoh', 'Unovah', 'Kalos', 'Alola', 'Galar', 'Paldea'];

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _ageController = TextEditingController(text: widget.initialAge);
    _gender = widget.initialGender;
    _typePreferences = widget.initialTypePreferences.split('/');
    _regionPreferences = widget.initialRegionPreferences.split('/');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _ageController.dispose();
    _gender = '';
    _typePreferences = [];
    _regionPreferences = [];
    super.dispose();
  }

  // XFile? _pickedImage;
  //
  // Future<void> _getImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);
  //   setState(() {
  //     _pickedImage = pickedFile;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user!.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData? userData = snapshot.data;
                return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () => _getImage(ImageSource.gallery),
                        //   child: const Text('Choose from Gallery'),
                        // ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: 'Age'),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // Dropdown box for the "Looking" section
                        const Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        DropdownButtonFormField<String>(
                          value: _gender ?? userData!.gender,
                          onChanged: (val) {
                            setState(() => _gender = val!);
                          },
                          items: genders.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        // Dropdown box for the "Looking" section
                        const Text(
                            'Type Preference/s',
                            style: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        MultiSelectDialogField(
                            title: const Column(
                              children: [
                                Text(
                                  'Types',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 5),
                                Divider(),
                              ],
                            ),
                            initialValue: _typePreferences,
                            items: types.map((e) => MultiSelectItem(e, e)).toList(),
                            itemsTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            selectedItemsTextStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                            selectedColor: Colors.blue,
                            cancelText: const Text('Cancel', style: TextStyle(color: Colors.white),),
                            confirmText: const Text('Save', style: TextStyle(color: Colors.white),),
                            buttonText: const Text('Type/s', style: TextStyle(fontSize: 15),),
                            onConfirm: (List<String> selected) {
                              setState(() => _typePreferences = selected);
                            }
                        ),
                        const SizedBox(height: 10),
                        // Dropdown box for the "Looking" section
                        const Text(
                            'Region Preference/s',
                            style: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        MultiSelectDialogField(
                            title: const Column(
                              children: [
                                Text(
                                  'Regions',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 5),
                                Divider(),
                              ],
                            ),
                            initialValue: _regionPreferences,
                            items: regions.map((e) => MultiSelectItem(e, e)).toList(),
                            itemsTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            selectedItemsTextStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                            selectedColor: Colors.blue,
                            cancelText: const Text('Cancel', style: TextStyle(color: Colors.white),),
                            confirmText: const Text('Save', style: TextStyle(color: Colors.white),),
                            buttonText: const Text('Region/s', style: TextStyle(fontSize: 15),),
                            onConfirm: (List<String> selected) {
                              setState(() => _regionPreferences = selected);
                            }
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Perform sign-up functionality here
                                if (_formKey.currentState!.validate()) {
                                  _updateProfileAndPop();
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        )
                      ],
                    )
                );
              } else {
                return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () => _getImage(ImageSource.gallery),
                        //   child: const Text('Choose from Gallery'),
                        // ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(labelText: 'OwO'),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: 'Age'),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // Dropdown box for the "Looking" section
                        const Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        DropdownButtonFormField<String>(
                          value: _gender ?? 'Female',
                          onChanged: (val) {
                            setState(() => _gender = val!);
                          },
                          items: genders.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        // Dropdown box for the "Looking" section
                        const Text(
                            'Type Preference/s',
                            style: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        MultiSelectDialogField(
                            title: const Column(
                              children: [
                                Text(
                                  'Types',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 5),
                                Divider(),
                              ],
                            ),
                            initialValue: _typePreferences,
                            items: types.map((e) => MultiSelectItem(e, e)).toList(),
                            itemsTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            selectedItemsTextStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                            selectedColor: Colors.blue,
                            cancelText: const Text('Cancel', style: TextStyle(color: Colors.white),),
                            confirmText: const Text('Save', style: TextStyle(color: Colors.white),),
                            buttonText: const Text('Type/s', style: TextStyle(fontSize: 15),),
                            onConfirm: (List<String> selected) {
                              setState(() => _typePreferences = selected);
                            }
                        ),
                        const SizedBox(height: 10),
                        // Dropdown box for the "Looking" section
                        const Text(
                            'Region Preference/s',
                            style: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        MultiSelectDialogField(
                            title: const Column(
                              children: [
                                Text(
                                  'Regions',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 5),
                                Divider(),
                              ],
                            ),
                            initialValue: _regionPreferences,
                            items: regions.map((e) => MultiSelectItem(e, e)).toList(),
                            itemsTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            selectedItemsTextStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                            selectedColor: Colors.blue,
                            cancelText: const Text('Cancel', style: TextStyle(color: Colors.white),),
                            confirmText: const Text('Save', style: TextStyle(color: Colors.white),),
                            buttonText: const Text('Region/s', style: TextStyle(fontSize: 15),),
                            onConfirm: (List<String> selected) {
                              setState(() => _regionPreferences = selected);
                            }
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Perform sign-up functionality here
                                if (_formKey.currentState!.validate()) {
                                  _updateProfileAndPop();
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        )
                      ],
                    )
                );
              }
            },
          ),
        )
      ),
    );
  }

  void _updateProfileAndPop() {
    final newUsername = _usernameController.text.trim();
    final newAge = _ageController.text.trim();
    final newGender = _gender.toString().trim();
    final newTypePreferences = _typePreferences.join('/').toString();
    final newRegionPreferences = _regionPreferences.join('/').toString();
    Navigator.pop(context, {
      'username': newUsername,
      'age': newAge,
      'gender': newGender,
      'typePreferences': newTypePreferences,
      'regionPreferences': newRegionPreferences,
    });
  }
}

