import 'package:flutter/cupertino.dart';
import 'package:pokedopt/models/user.dart';
import 'package:pokedopt/screens/main/pokedopt.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return user == null ? const Authenticate() : const PokeDopt(likedPokemons: [],);
  }
}