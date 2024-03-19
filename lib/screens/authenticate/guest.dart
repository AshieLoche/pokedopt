import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';
// import '../main/profileData.dart';

class Guest extends StatefulWidget {
  const Guest({super.key});

  @override
  State<Guest> createState() => _GuestState();
}

class _GuestState extends State<Guest> {

  final AuthService _auth = AuthService();
  final signUpEmailController = TextEditingController();
  final loginEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _ageController = TextEditingController();
  late String _gender = '';
  late List<String> _typePreferences = [];
  late List<String> _regionPreferences = [];

  final List<String> genders = ['Male', 'Female', 'Non-Binary'];
  final List<String> types = ['Fire', 'Water', 'Grass', 'Electric', 'Ghost', 'Steel', 'Ground', 'Rock', 'Fairy', 'Dragon', 'Poison', 'Dark', 'Psychic', 'Bug', 'Fighting', 'Normal', 'Flying', 'Ice'];
  final List<String> regions = ['Kanto', 'Johto', 'Hoenn', 'Sinnoh', 'Unovah', 'Kalos', 'Alola', 'Galar', 'Paldea'];

  // Text Field State
  String email = '', password = '', confirmPassword = '', loginError = '', signUpError = '';
  bool loginReload = false, signUpReload = false;
  bool loading = false;

  void logInForm() {

    final loginFormKey = GlobalKey<FormState>();

    passwordController.text = '';
    confirmPasswordController.text = '';
    setState(() {
      email = '';
      password = '';
      confirmPassword = '';
      loginError = (loginReload) ? loginError : '';
      loginReload = false;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SingleChildScrollView(
            child: Column(
              children: [
                Text("Log In"),
                Divider(),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: loginEmailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                      errorText: loginError.isNotEmpty ? loginError : null,
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      errorText: loginError.isNotEmpty ? loginError : null,
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    obscureText: true,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        signUpForm();
                      },
                      child: const Text('Sign Up for Pokedopt'),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Perform sign-up functionality here
                if (loginFormKey.currentState!.validate()) {

                  Navigator.of(context).pop();
                  setState(() => loading = true);

                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                  if (result == null) {
                    setState(() {
                      loginError = 'Incorrect email or password';
                      loginReload = true;
                      loading = false;
                    });
                    logInForm();
                  }

                }

              },
              child: const Text(
                'Log In',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );

  }

  void signUpForm() {

    final signupFormKey = GlobalKey<FormState>();

    passwordController.text = '';
    confirmPasswordController.text = '';
    setState(() {
      email = '';
      password = '';
      confirmPassword = '';
      signUpError = (signUpReload) ? signUpError : '';
      signUpReload = false;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SingleChildScrollView(
            child: Column(
              children: [
                Text("Sign Up"),
                Divider(),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: signupFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: signUpEmailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                      errorText: signUpError.isNotEmpty ? signUpError : null,
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }

                      final lowercaseRegex = RegExp(r'[a-z]');
                      final uppercaseRegex = RegExp(r'[A-Z]');
                      final digitRegex = RegExp(r'\d');
                      final specialRegex = RegExp(r'\W');

                      List<String> errors = [];

                      if (!lowercaseRegex.hasMatch(value)) {
                        errors.add('Must contain at least 1 lowercase');
                      }
                      if (!uppercaseRegex.hasMatch(value)) {
                        errors.add('Must contain at least 1 uppercase');
                      }
                      if (!digitRegex.hasMatch(value)) {
                        errors.add('Must contain at least 1 number');
                      }
                      if (!specialRegex.hasMatch(value)) {
                        errors.add('Must contain at least 1 special char');
                      }

                      if (value.length < 8 || value.length > 12) {
                        errors.add('Must be 8 - 12 chars long');
                      }

                      return errors.isEmpty ? null : errors.join('\n'); // Combine errors into a single string
                    },
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val != password || val!.isEmpty ? 'Incorrect Password' : null,
                    onChanged: (val) {
                      setState(() => confirmPassword = val);
                    },
                    obscureText: true,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        logInForm();
                      },
                      child: const Text('Already have an account?'),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'), // Close button
            ),
            ElevatedButton(
              onPressed: () async {
                // Perform sign-up functionality here
                if (signupFormKey.currentState!.validate()) {

                  Navigator.of(context).pop();
                  setState(() => loading = true);

                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                  if (result == "[firebase_auth/email-already-in-use] The email address is already in use by another account." || result == "[firebase_auth/invalid-email] The email address is badly formatted.") {
                    setState(() {
                      signUpError = result == "[firebase_auth/email-already-in-use] The email address is already in use by another account." ? 'Email is already in use' : 'Invalid Email';
                      signUpReload = true;
                      loading = false;
                    });
                    signUpForm();
                  }

                }
              },
              child: const Text('Sign Up', style: TextStyle(color: Colors.orange)),
            ),
          ],
        );
      },
    );

  }

  void newRegisterForm() {

    final newRegisterFormKey = GlobalKey<FormState>();

    passwordController.text = '';
    confirmPasswordController.text = '';
    setState(() {
      email = '';
      password = '';
      confirmPassword = '';
      signUpError = (signUpReload) ? signUpError : '';
      signUpReload = false;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SingleChildScrollView(
            child: Column(
              children: [
                Text("Sign Up"),
                Divider(),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
                key: newRegisterFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      value: _gender,
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
                            if (newRegisterFormKey.currentState!.validate()) {
                              // _updateProfileAndPop();
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    )
                  ],
                )
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'), // Close button
            ),
            ElevatedButton(
              onPressed: () async {
                // Perform sign-up functionality here
                if (newRegisterFormKey.currentState!.validate()) {

                  Navigator.of(context).pop();
                  setState(() => loading = true);

                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                  if (result == "[firebase_auth/email-already-in-use] The email address is already in use by another account." || result == "[firebase_auth/invalid-email] The email address is badly formatted.") {
                    setState(() {
                      signUpError = result == "[firebase_auth/email-already-in-use] The email address is already in use by another account." ? 'Email is already in use' : 'Invalid Email';
                      signUpReload = true;
                      loading = false;
                    });
                    signUpForm();
                  }

                }
              },
              child: const Text('Sign Up', style: TextStyle(color: Colors.orange)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    signUpEmailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      resizeToAvoidBottomInset: false, // Set to false to prevent resizing when keyboard appears
      appBar: AppBar(
        title: const Center(
          child: Text('PokéDopt'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 5), // Add some space between the search bar and the image
          Image.asset(
            'assets/bannerPikachu.jpg',
            fit: BoxFit.fill, // Ensure the image fills its container
            height: 250,
          ),
          Container(
            color: Colors.grey.shade700, // Set the background color to a grayish shade
            padding: const EdgeInsets.all(16.0), // Add padding to create space between the content and the container edge
            child: Column(
              children: [
                const SizedBox(height: 7.5), // Add some space between the image and the text
                const Center(
                  child: Text(
                    "Finding the best Poké Partner has never been easier !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "With PokéDopt, starting your Pokémon journey just requires a couple of clicks, and soon you’ll have a forever companion! Not only that, for people who just want a normal life and share their moments with their Poké Pals, then use the built-in social media platform to tell the world about the joys between you and your Pokémon.",
                    textAlign: TextAlign.center, // Center align the text
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add space between the text and buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {

                        logInForm();

                        // dynamic result = await _auth.signInAnon();
                        //
                        // if (result == null) {
                        //   print('Error signing in');
                        // } else {
                        //   // Add your login functionality here
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const EditProfileScreen(
                        //         initialUsername: '',
                        //         initialAge: '',
                        //         initialGender: 'Male',
                        //         initialTypePreferences: '',
                        //         initialRegionPreferences: '',
                        //         newRegister: true,
                        //       ),
                        //     ),
                        //   );
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius here
                        ),
                      ),
                      child: const Text('Log in'),
                    ),
                    const SizedBox(height: 10), // Add space between the buttons
                    ElevatedButton(
                      onPressed: () {

                        signUpForm();

                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius here
                        ),
                      ),
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Add some space between the gray box and the copyright text
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle tap event if needed
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: const Text(
                      "© PokeDopt by Ashie Loche and Patrick Ramos",
                      style: TextStyle(
                        fontSize: 10, // Adjust the font size here
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle tap event if needed
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: const Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 10, // Adjust the font size here
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle tap event if needed
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: const Text(
                      "Customer Care",
                      style: TextStyle(
                        fontSize: 10, // Adjust the font size here
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}