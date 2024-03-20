import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:pokedopt/shared/loading.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/databaseService.dart';

class ProfileForm extends StatefulWidget {

  const ProfileForm({super.key,});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {

  final _formKey = GlobalKey<FormState>();
  late XFile _image = XFile('');
  final _usernameController = TextEditingController();
  final _ageController = TextEditingController();
  late String _gender = 'Male';
  late List<String> _typePreferences = [];
  late List<String> _regionPreferences = [];
  bool newPfp = false;

  final List<String> genders = ['Male', 'Female', 'Non-Binary'];
  final List<String> types = ['Fire', 'Water', 'Grass', 'Electric', 'Ghost', 'Steel', 'Ground', 'Rock', 'Fairy', 'Dragon', 'Poison', 'Dark', 'Psychic', 'Bug', 'Fighting', 'Normal', 'Flying', 'Ice'];
  final List<String> regions = ['Kanto', 'Johto', 'Hoenn', 'Sinnoh', 'Unovah', 'Kalos', 'Alola', 'Galar', 'Paldea'];

  @override
  void dispose() {
    _usernameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user!.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;
              Future<String> imagePath = DatabaseService().getImageURL(userData!.pfpUrl);
              _usernameController.text = userData.username;
              _ageController.text = userData.age;
              _gender = userData.gender;
              _typePreferences = userData.typePreferences.split('/');
              _regionPreferences = userData.regionPreferences.split('/');
              return Column(
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                              'Profile Pic',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              FutureBuilder<String>(
                                future: imagePath,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return (newPfp) ?
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundImage: FileImage(File(_image.path)), // Use FileImage for picked image
                                    ) :
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(snapshot.data!) ,
                                    );
                                  } else if (snapshot.hasError) {
                                    return const CircleAvatar(
                                      radius: 60,
                                      backgroundImage: AssetImage('assets/defaultPfp.png'),
                                    );
                                  }
                                  // Display a progress indicator or placeholder while loading
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(120.0), // Circular clipping
                                    child: const SizedBox(
                                      width: 120.0,
                                      height: 120.0,
                                      child: Loading(), // Your loading indicator widget
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 30,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(),
                                onPressed: () async {
                                  if (newPfp) {
                                    setState(() => newPfp = false);
                                  } else {
                                    final picker = ImagePicker();
                                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      _image = pickedImage!;
                                      newPfp = true;
                                    });
                                  }
                                },
                                child: (newPfp) ? const Text('Clear') : const Text('Choose from Gallery'),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter a valid age';
                              } else if (val.contains(' ')){
                                return 'No spaces allowed';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                            decoration: const InputDecoration(
                                labelText: 'Age',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                            validator: (val) {
                              final digitRegex = RegExp(r'\d');
                              if (val == null || val.isEmpty || !digitRegex.hasMatch(val)) {
                                return 'Please enter a valid age';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          DropdownButtonFormField<String>(
                            value: _gender,
                            onChanged: (val) {
                              _gender = val!;
                            },
                            items: genders.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              'Type Preference/s',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                                selected.remove('');
                                _typePreferences = selected;
                              }
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              'Region Preference/s',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                                selected.remove('');
                                _regionPreferences = selected;
                              }
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // Perform sign-up functionality here
                                  if (_formKey.currentState!.validate()) {

                                    await DatabaseService(uid: user.uid).updateUserData(
                                        (newPfp) ? await DatabaseService().uploadPfpImage(_image, user.uid) : userData.pfpUrl,
                                      _usernameController.text.trim(),
                                      _ageController.text.trim(),
                                      _gender,
                                      _typePreferences.join('/').toString(),
                                      _regionPreferences.join('/').toString(),
                                      userData.createdAt,
                                    ).whenComplete(() => Navigator.of(context).pop(true));
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: const Center(
                  child: Loading(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}