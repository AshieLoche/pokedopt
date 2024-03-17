import 'package:flutter/material.dart';
import 'pokedopt.dart';// Import the Pokemon class

class PokeList extends StatelessWidget {
  final List<Pokemon> likedPokemons; // Change the type to List<Pokemon>

  const PokeList({super.key, required this.likedPokemons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeList Pages'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: likedPokemons.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  showPokemonDialog(
                      context, likedPokemons[index]); // Pass the Pokemon object
                },
                child: ListTile(
                  title: Text(likedPokemons[index].personalName),
                  // Display personalName instead of just the name
                  leading: Image.asset(
                    likedPokemons[index].imageUrl,
                    // Use imageUrl from the Pokemon object
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
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
                AssetImage('assets/pokedopt.ico'), color: Colors.orange),
            label: 'PokeDopt',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage('assets/pokepals.ico'), color: Colors.orange),
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

  void showPokemonDialog(BuildContext context, Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pokemon.personalName),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Image.asset(
                      pokemon.imageUrl,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Text('Species: ${pokemon.name}'),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Type: ${pokemon.type}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: Text('Description: ${pokemon.description}'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}