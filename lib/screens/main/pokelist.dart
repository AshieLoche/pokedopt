import 'package:flutter/material.dart';


class PokeList extends StatelessWidget {
  final List<String> likedPokemons;

  const PokeList({super.key, required this.likedPokemons});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeList Pages'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:
      ListView.builder(
        itemCount: likedPokemons.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  showPokemonDialog(context, likedPokemons[index]);
                },
                child: ListTile(
                  title: Text(likedPokemons[index]),
                  leading: Image.asset(
                    'assets/pokemon/${likedPokemons[index].toLowerCase()}.jpg',
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
            icon: ImageIcon(AssetImage('assets/pokedopt.ico'), color: Colors.orange),
            label: 'PokeDopt',
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
  void showPokemonDialog(BuildContext context, String pokemonName) {


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Pokemon'),
          content: Text('You selected: $pokemonName'),
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

