import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pokedopt/screens/main/pokelist.dart';
import 'package:pokedopt/screens/pokedoptScreen/pokemonCard.dart';
import 'package:pokedopt/screens/main/profileData.dart';
import 'package:pokedopt/screens/pokedoptScreen/pokemonCardContent.dart';
import 'package:pokedopt/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/pokemon.dart';

class PokeDopt extends StatefulWidget {
  final List<Pokemon> likedPokemons;

  const PokeDopt({
    super.key,
    required this.likedPokemons,
  });


  @override
  PokeDoptState createState() => PokeDoptState();

}

class PokeDoptState extends State<PokeDopt> {

  //List<Pokemon> likedPokemons = [];

  // final List<Pokemon> pokemons = [
  //   Pokemon(personalName: 'My Pokemon 1',name: 'Gengar', imageUrl: 'assets/pokemon/gengar.jpg',description: 'To steal the life of its target, it slips into the prey’s shadow and silently waits for an opportunity.', type: 'Ghost/Poison'),
  //   Pokemon(personalName: 'My Pokemon 2',name: 'Dragonite', imageUrl: 'assets/pokemon/dragonite.jpg',description: 'It is said that somewhere in the ocean lies an island where these gather. Only they live there.', type: 'Dragon'),
  //   Pokemon(personalName: 'My Pokemon 3',name: 'Chandelure', imageUrl: 'assets/pokemon/chandelure.jpg',description: 'The spirits burned up in its ominous flame lose their way and wander this world forever.', type: 'Ghost'),
  //   // Add more Pokemon data here
  // ];
  //
  // // Function to update likedPokemons list
  // void updateLikedPokemons(Pokemon pokemons) {
  //   setState(() {
  //     if (!likedPokemons.contains(pokemons)) {
  //       likedPokemons.add(pokemons);
  //     }
  //   }); // Pass likedPokemons list to PokeList when navigating
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PokeList(likedPokemons: likedPokemons),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Pokemon>>.value(
      value: DatabaseService().pokemons,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
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
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Add your search logic here
              },
            ),
            IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () {
                // Add your filter logic here
              },
            ),
          ],
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                Navigator.pushNamed(context, '/PokeList');
                break;
            }
          },
        ),
      ),
    );
  }
}