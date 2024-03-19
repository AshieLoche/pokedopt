import 'package:flutter/material.dart';

class PokeList extends StatelessWidget {


  const PokeList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeList Pages'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
}
