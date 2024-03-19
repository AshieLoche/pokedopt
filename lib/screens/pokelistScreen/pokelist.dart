import 'package:flutter/material.dart';
import 'package:pokedopt/models/pokemon.dart';
import 'package:pokedopt/screens/pokedoptScreen/pokemonCard.dart';
import 'package:pokedopt/screens/pokedoptScreen/pokemonCardContent.dart';

class PokeList extends StatefulWidget {
  final List<Pokemon> likedPokemonList;

  const PokeList({Key? key, required this.likedPokemonList}) : super(key: key);

  @override
  PokeListState createState() => PokeListState();
}

class PokeListState extends State<PokeList> {
  @override
  Widget build(BuildContext context) {
    print('Liked Pokémon List: ${widget.likedPokemonList}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Pokémon'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.likedPokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = widget.likedPokemonList[index];
          return Card(
            child: ListTile(
              leading: Image.network(pokemon.imageURL), // Image on the left
              title: Text(pokemon.name), // Name on the right
              onTap: () {
                // Add your onTap logic here
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.orange),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/pokedopt.ico'),
              color: Colors.orange,
            ),
            label: 'PokeDopt',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/pokepals.ico'),
              color: Colors.orange,
            ),
            label: 'PokeList',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/Profile');
              break;
            case 1:
              Navigator.pushNamed(context, '/PokeDopt');
              break;
            case 2:
              Navigator.pushNamed(context, '/PokeList');
              break;
          }
        },
      ),
    );
  }
}
