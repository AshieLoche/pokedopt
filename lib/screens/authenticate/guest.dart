import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../main/pokedopt.dart';
import '../../services/auth.dart';

class Guest extends StatefulWidget {
  const Guest({Key? key}) : super(key: key);

  @override
  State<Guest> createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  final AuthService _auth = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Guest");
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('PokéDopt'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Image.asset(
              'assets/bannerPikachu.jpg',
              fit: BoxFit.fill,
              height: 250,
            ),
            Container(
              color: Colors.grey.shade700,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 7.5),
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
                      "With PokéDopt, starting your Pokemon journey just requires a couple of clicks, and soon you’ll have a forever companion! Not only that, for people who just want a normal life and share their moments with their Poké Pals, then use the built-in social media platform to tell the world about the joys between you and your Pokémon.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          dynamic result = await _auth.signInAnon();
                          if (result == null) {
                            if (kDebugMode) {
                              print('Error signing in');
                            }
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PokeDopt(likedPokemons: [],)),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Log in'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: AlertDialog(
                                  title: const Center(child: Text("Sign Up")),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(
                                            labelText: 'Name',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        PasswordField(
                                          controller: _passwordController,
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: _confirmPasswordController,
                                          decoration: const InputDecoration(
                                            labelText: 'Confirm Password',
                                            border: OutlineInputBorder(),
                                          ),
                                          obscureText: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        String name = _nameController.text;
                                        String password = _passwordController.text;
                                        String confirmPassword = _confirmPasswordController.text;

                                        if (name.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Error'),
                                                content: const Text('Please fill in all fields.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else if (_validatePassword(password)) {
                                          // Password meets requirements, proceed with sign-up
                                          Navigator.of(context).pop();
                                          // Perform sign-up functionality here
                                        } else {
                                          // Password does not meet requirements, show error message dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Invalid Password'),
                                                content: const Text('Password must be between 8-12 characters,'
                                                    ' contain at least one uppercase letter ,'
                                                    ' one lowercase letter, one number,'
                                                    ' and one special character.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: const Text('Sign Up', style: TextStyle(color: Colors.orange)),
                                    ),

                                  ],
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                          fontSize: 10,
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
                          fontSize: 10,
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
                          fontSize: 10,
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
      ),
    );
  }

  // Function to validate password
  bool _validatePassword(String password) {
    // Password length between 8-12 characters
    if (password.length < 8 || password.length > 12) {
      return false;
    }
    // Check if password contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    // Check if password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    // Check if password contains at least one number
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    // Check if password contains at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    return true; // Password meets all requirements
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
      obscureText: _isObscure,
    );
  }
}
