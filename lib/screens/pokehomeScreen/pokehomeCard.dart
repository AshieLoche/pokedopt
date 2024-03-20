import 'package:flutter/material.dart';
import 'package:pokedopt/screens/pokehomeScreen/pokehomeCardContent.dart';
import 'package:provider/provider.dart';
import '../../models/pokemon.dart';

class PokeHomeCard extends StatefulWidget {
  const PokeHomeCard({super.key});

  @override
  PokeHomeCardState createState() => PokeHomeCardState();
}

class PokeHomeCardState extends State<PokeHomeCard> {

  @override
  Widget build(BuildContext context) {
    final pokemons = Provider.of<List<Pokemon>>(context);

    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        return PokeHomeCardContent(pokemon: pokemons[index]);
      },
    );
  }
}