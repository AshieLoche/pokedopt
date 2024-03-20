import 'package:flutter/material.dart';
import 'package:pokedopt/screens/pokedoptScreen/pokemonCardContent.dart';
import 'package:provider/provider.dart';
import '../../models/pokemon.dart';

class PokemonCard extends StatefulWidget {
  const PokemonCard({super.key});

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