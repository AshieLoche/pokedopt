import 'package:flutter/material.dart';
import 'package:pokedopt/screens/pokehomeScreen/pokehomeCard.dart';
import 'package:pokedopt/services/databaseService.dart';
import 'package:provider/provider.dart';

import '../../models/pokemon.dart';
import '../../models/user.dart';

class PokeHome extends StatefulWidget {

  const PokeHome({super.key});

  @override
  PokeHomeState createState() => PokeHomeState();

}

class PokeHomeState extends State<PokeHome> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<Pokemon>>.value(
            value: DatabaseService(uid: user!.uid).pokemons,
            initialData: const []
        ),
        StreamProvider<List<FavouritePokemon>>.value(
          value: DatabaseService(uid: user.uid).favourites,
          initialData: const [],
          catchError: (_, __) => const[],
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageIcon(AssetImage('assets/pokedopt.ico')),
              SizedBox(width: 3),
              Text('PokeDopt'),
            ],
          ),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(),
            Expanded(
              child: PokeHomeCard(),
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