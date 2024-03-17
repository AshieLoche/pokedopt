import 'package:flutter/material.dart';
import '../../services/auth.dart';

class Guest extends StatefulWidget {
  const Guest({super.key});

  @override
  State<Guest> createState() => _GuestState();
}

class _GuestState extends State<Guest> {

  final AuthService _auth = AuthService();
  final _loginFormKey = GlobalKey<FormState>();
  late final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Text Field State
  String email = '', password = '', confirmPassword = '', error = '';

  void logInForm() {

    setState(() {
      email = '';
      password = '';
      confirmPassword = '';
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
              key: _loginFormKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
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
                print(email);
                print(password);
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

    setState(() {
      email = '';
      password = '';
      confirmPassword = '';
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
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                      errorText: error.isNotEmpty ? error : null,
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
                    validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
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
                passwordController.text = '';
                confirmPasswordController.text = '';
                Navigator.of(context).pop();
              },
              child: const Text('Close'), // Close button
            ),
            ElevatedButton(
              onPressed: () async {
                // Perform sign-up functionality here
                if (signupFormKey.currentState!.validate()) {
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                  if (result == "[firebase_auth/email-already-in-use] The email address is already in use by another account." || result == "[firebase_auth/invalid-email] The email address is badly formatted.") {
                    setState(() => error = result == "[firebase_auth/email-already-in-use] The email address is already in use by another account." ? 'Email is already in use' : 'Invalid Email');
                    Navigator.of(context).pop();
                    passwordController.text = '';
                    confirmPasswordController.text = '';
                    signUpForm();
                  } else {
                    setState(() => error = '');
                    emailController.text = '';
                    passwordController.text = '';
                    confirmPasswordController.text = '';
                    Navigator.of(context).pop();
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
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onPressed: () {


                        logInForm();


                        // dynamic result = await _auth.signInAnon();
                        //
                        // if (result == null) {
                        //   if (kDebugMode) {
                        //     print('Error signing in');
                        //   }
                        // } else {
                        //   // Add your login functionality here
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => const PokeDopt()),
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