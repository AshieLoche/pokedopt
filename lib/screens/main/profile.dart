import 'package:flutter/material.dart';
import 'package:pokedopt/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  String name = 'Ashie Loche';
  String nickname = ' ';
  String gender = ' ';
  String status = ' ';
  String looking = ' ';
  String motto = ' ';
  String bio = 'Tell the others about your self';

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
          )
        ],
      ),
      body: Padding(
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
                      name,
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
                  _buildProfileField(label: 'Nickname', value: nickname),
                  _buildProfileField(label: 'Gender', value: gender),
                  _buildProfileField(label: 'Status', value: status),
                  _buildProfileField(label: 'Looking', value: looking),
                  _buildProfileField(label: 'Motto', value: motto),
                  const ListTile(
                    title: Text('Bio'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Add border
                      borderRadius: BorderRadius.circular(10), // Add border radius for rounded corners
                    ),
                    padding: const EdgeInsets.all(10), // Add padding for inner content spacing
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                      children: [
                        Text(
                          bio, // Bio text here
                          textAlign: TextAlign.left, // Align text to the left
                        ),
                        const SizedBox(height: 30.0), // Add spacing between text and bottom border
                      ],
                    ),
                  ),
                  // Add other profile fields here
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.orange),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/pokedopt.ico'),color: Colors.orange,),
            label: 'PokeHome',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/pokepals.ico'),color: Colors.orange,),
            label: 'PokeList',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/Profile'); // Navigate to profile page
              break;
            case 1:
            // Handle pokehome icon tap
              Navigator.pushNamed(context, '/PokeDopt');
              break;
            case 2:
            // Handle pokelist icon tap
              Navigator.pushNamed(context, '/PokeList');
              break;
          }
        },
      ),
    );
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

  void _navigateToEditProfileScreen() async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          initialName: name,
          initialNickname: nickname,
          initialGender: gender,
          initialStatus: status,
          initialLooking: looking,
          initialBio: bio,
          initialMotto: motto,
        ),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        name = updatedProfile['name'];
        nickname = updatedProfile['nickname'];
        gender = updatedProfile['gender'];
        status = updatedProfile['status'];
        looking = updatedProfile['looking'];
        bio = updatedProfile['bio'];
        motto = updatedProfile['motto'];
        // Update other fields similarly
      });
    }
  }
}

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialNickname;
  final String initialGender;
  final String initialStatus;
  final String initialLooking;
  final String initialBio;
  final String initialMotto;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialNickname,
    required this.initialGender,
    required this.initialStatus,
    required this.initialLooking,
    required this.initialBio,
    required this.initialMotto,

  });

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _nicknameController;
  late TextEditingController _genderController;
  late TextEditingController _statusController;
  late TextEditingController _bioController;
  late TextEditingController _mottoController;
  late String _lookingValue;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _nicknameController = TextEditingController(text: widget.initialNickname);
    _genderController = TextEditingController(text: widget.initialGender);
    _statusController = TextEditingController(text: widget.initialStatus);
    _statusController = TextEditingController(text: widget.initialLooking);
    _bioController = TextEditingController(text: widget.initialBio);
    _mottoController = TextEditingController(text: widget.initialMotto);
    _lookingValue = 'Yes';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _genderController.dispose();
    _statusController.dispose();
    _bioController.dispose();
    _mottoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(labelText: 'Nickname'),
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              TextFormField(
                controller: _mottoController,
                decoration: const InputDecoration(labelText: 'Motto'),
              ),
          const SizedBox(height: 10),
          // Dropdown box for the "Looking" section
          const Text(
                  'Looking?',
                  style: TextStyle(
                    fontSize: 15,
                  )
              ),
          DropdownButtonFormField<String>(
            value: _lookingValue,
            onChanged: (newValue) {
              setState(() {
                _lookingValue = newValue!;
              });
            },
            items: <String>['Yes', 'No', 'Maybe'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
              const Text(
                  'Bio',
                style: TextStyle(
                  fontSize: 15,
                )
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Add border
                  borderRadius: BorderRadius.circular(10), // Add border radius for rounded corners
                ),
                child: TextFormField(
                  controller: _bioController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Enter your bio here...',
                    contentPadding: EdgeInsets.all(10), // Add padding for text input
                    border: InputBorder.none,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  _updateProfileAndPop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfileAndPop() {
    final newName = _nameController.text;
    final newNickname = _nicknameController.text;
    final newGender = _genderController.text;
    final newStatus = _statusController.text;
    final newLooking = _lookingValue.toString();
    final newBio = _bioController.text;
    final newMotto = _mottoController.text;
    Navigator.pop(context, {
      'name': newName,
      'nickname': newNickname,
      'gender': newGender,
      'status': newStatus,
      'looking': newLooking,
      'bio': newBio,
      'motto': newMotto,
    });
  }
}

