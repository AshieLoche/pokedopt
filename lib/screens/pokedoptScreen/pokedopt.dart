import 'package:flutter/material.dart';
import 'package:pokedopt/screens/pokedoptScreen/pokemonCard.dart';
import 'package:pokedopt/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/pokemon.dart';

class PokeDopt extends StatefulWidget {

  const PokeDopt({super.key});

  @override
  PokeDoptState createState() => PokeDoptState();

}

class PokeDoptState extends State<PokeDopt> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Pokemon>>.value(
      value: DatabaseService().pokemons,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 52),
              ImageIcon(AssetImage('assets/pokedopt.ico')),
              SizedBox(width: 3),
              Text('PokeDopt'),
              SizedBox(width: 1),
            ],
          ),
          actions: const [
            SizedBox(width: 48),
          ],
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: PokemonCard(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.orange),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/pokedopt.ico'), color: Colors.orange),
              label: 'PokeHome',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/pokepals.ico'), color: Colors.orange),
              label: 'PokeList',
            ),
          ],
          onTap: (int index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/Profile');
                break;
              case 1:
                Navigator.pushNamed(context, '/PokeHome');
                break;
              case 2:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PokeList(likedPokemons: likedPokemons),
                //   ),
                // );
                break;
            }
          },
        ),
      ),
    );
  }
}