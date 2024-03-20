import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pokemon.dart';

class PokeListCardContent extends StatefulWidget {

  final FavouritePokemon favourite;
  const PokeListCardContent({
    super.key,
    required this.favourite,
  });

  @override
  State<PokeListCardContent> createState() => _PokeListCardContentState();
}

class _PokeListCardContentState extends State<PokeListCardContent> {

  late FavouritePokemon favourite;

  @override
  void initState() {
    super.initState();
    favourite = widget.favourite;
  }

  @override
  Widget build(BuildContext context) {
    final pokemons = Provider.of<List<Pokemon>>(context);
    print(pokemons[0].id);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: GestureDetector(
          onTap: () {
            // showPokemonDialog(
            //     context, likedPokemons[index]); // Pass the Pokemon object
          },
          child: ListTile(
            title: Text('likedPokemons[index].personalName'),
            // Display personalName instead of just the name
            // leading: Image.asset(
            //   likedPokemons[index].imageUrl,
            //   // Use imageUrl from the Pokemon object
            //   width: 50,
            //   height: 50,
            // ),
          ),
        ),
      ),
    );
  }
}
