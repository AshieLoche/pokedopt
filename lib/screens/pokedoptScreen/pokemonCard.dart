import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedopt/screens/pokedoptScreen/pokemonCardContent.dart';
import 'package:provider/provider.dart';
import '../../models/pokemon.dart';
import '../../services/database.dart';

class PokemonCard extends StatefulWidget {
  const PokemonCard({super.key});

  // final Pokemon pokemon;
  // final Function(Pokemon) onLiked;
  // final String description;
  //
  // const PokemonCard({
  //   super.key,
  //   required this.pokemon,
  //   required this.onLiked,
  //   required this.description,
  // });

  @override
  PokemonCardState createState() => PokemonCardState();
}

class PokemonCardState extends State<PokemonCard> {

  @override
  Widget build(BuildContext context) {
    final pokemons = Provider.of<List<Pokemon>>(context);

    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        return PokemonCardContent(pokemon: pokemons[index]);
      },
    );
  }
}