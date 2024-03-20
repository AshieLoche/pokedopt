import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pokedopt/screens/pokelistScreen/pokelistCard.dart';
import 'package:pokedopt/services/database.dart';
import 'package:provider/provider.dart';
import '../../models/pokemon.dart';
import '../../models/user.dart';

class PokeList extends StatefulWidget {
  const PokeList({super.key});

  @override
  State<PokeList> createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return MultiProvider(
      providers: [
          StreamProvider<List<FavouritePokemon>>.value(
              value: DatabaseService(uid: user!.uid).favourites,
              initialData: const []
          ),
          StreamProvider<List<Pokemon>>.value(
              value: DatabaseService().pokemons,
              initialData: const []
          ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PokeList'),
          centerTitle: true,
        ),
        body: const Column(
          children: [
            Divider(),
            Expanded(
              child:PokeListCard(),
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