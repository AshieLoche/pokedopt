import 'package:flutter/cupertino.dart';
import 'package:pokedopt/models/user.dart';
import 'package:pokedopt/screens/pokehomeScreen/pokehome.dart';
import 'package:provider/provider.dart';
import '../miscellaneous/guest.dart';

// Checks If User is logged in or not
class Wrapper extends StatelessWidget {
  const Wrapper({super.key,});

  @override
  Widget build(BuildContext context) {
    // Gets the Value of the Provider from main()
    final user = Provider.of<User?>(context);

    // Directs the user to Guest() or to the home page, PokeHome(), if the user is logged out or logged in respectively
    return user == null ? const Guest() : const PokeHome();
  }
}