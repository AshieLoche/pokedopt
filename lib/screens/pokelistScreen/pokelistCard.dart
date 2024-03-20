import 'package:flutter/material.dart';
import 'package:pokedopt/models/pokemon.dart';
import 'package:pokedopt/screens/pokelistScreen/pokelistCardContent.dart';
import 'package:provider/provider.dart';


class PokeListCard extends StatefulWidget {
  const PokeListCard({super.key});

  @override
  State<PokeListCard> createState() => _PokeListCardState();
}

class _PokeListCardState extends State<PokeListCard> {

  @override
  Widget build(BuildContext context) {
    final favourites = Provider.of<List<FavouritePokemon>>(context);
    final pokemons = Provider.of<List<Pokemon>>(context);
    List<Pokemon> favouritePokemons = [];
    for (var favourite in favourites) {
      for (var pokemon in pokemons) {
        if (pokemon.id == favourite.pokemonId && !favouritePokemons.contains(pokemon)) {
          favouritePokemons.add(pokemon);
          break;
        }
      }
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        return PokeListCardContent(favouritePokemon: favouritePokemons[index]);
      },
    );
  }
}
