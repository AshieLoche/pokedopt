import 'package:flutter/material.dart';
import 'package:pokedopt/models/pokemon.dart';
import 'package:pokedopt/screens/pokelistScreen/pokelistCardContent.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/database.dart';

class PokeListCard extends StatefulWidget {
  const PokeListCard({super.key});

  @override
  State<PokeListCard> createState() => _PokeListCardState();
}

class _PokeListCardState extends State<PokeListCard> {

  @override
  Widget build(BuildContext context) {
    final favourites = Provider.of<List<FavouritePokemon>>(context);
    return ListView.builder(
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        return PokeListCardContent(favourite: favourites[index]);
      },
    );
  }

  // void showPokemonDialog(BuildContext context, Pokemon pokemon) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(pokemon.personalName),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(top: 1.0),
  //                   child: Image.asset(
  //                     pokemon.imageUrl,
  //                     width: 100,
  //                     height: 100,
  //                   ),
  //                 ),
  //                 const SizedBox(width: 25),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 18.0),
  //                         child: Text('Species: ${pokemon.name}'),
  //                       ),
  //                       const SizedBox(height: 5),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 8.0),
  //                         child: Text('Type: ${pokemon.type}'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 1),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 1.0),
  //               child: Text('Description: ${pokemon.description}'),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
