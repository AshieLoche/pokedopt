import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pokemon.dart';
import '../../models/user.dart';
import '../../services/database.dart';
import '../../shared/loading.dart';

class PokeListCardContent extends StatefulWidget {

  final Pokemon favouritePokemon;
  const PokeListCardContent({
    super.key,
    required this.favouritePokemon,
  });

  @override
  State<PokeListCardContent> createState() => _PokeListCardContentState();
}

class _PokeListCardContentState extends State<PokeListCardContent> {

  late Future<String> imageUrl;
  late Pokemon favouritePokemon;
  late bool _isFavourited;

  @override
  void initState() {
    super.initState();
    _isFavourited = false;
    favouritePokemon = widget.favouritePokemon;
  }

  @override
  Widget build(BuildContext context) {
    imageUrl = DatabaseService().getImageURL(favouritePokemon.imageURL);

    final user = Provider.of<User?>(context);
    final pokemons = Provider.of<List<Pokemon>>(context);
    for (var pokemon in pokemons) {
      if (pokemon.id == favouritePokemon.id) {
        setState(() {
          _isFavourited = true;
        });
        break;
      } else {
        setState(() {
          _isFavourited = false;
        });
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {
              showPokemonDialog(
                  context, favouritePokemon); // Pass the Pokemon object
            },
            child: ListTile(
              subtitle: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        favouritePokemon.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            _isFavourited ? Icons.favorite : Icons.favorite_border,
                            color: _isFavourited ? Colors.red : Colors.grey,
                          ),
                          iconSize: 50,
                          onPressed: () async {
                            setState(() {
                              _isFavourited = !_isFavourited;
                            });

                            await DatabaseService(uid: user!.uid).updateFavouriteData(favouritePokemon.id, favouritePokemon.name, _isFavourited);
                            Navigator.of(context).pop(true);
                            Navigator.pushNamed(context, '/PokeList');
                          }
                      )
                    ],
                  )
                ],
              ),
              // Display personalName instead of just the name
              title: FutureBuilder<String>(
                future: imageUrl,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(snapshot.data!),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  // Display a progress indicator or placeholder while loading

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // Circular clipping
                    child: const SizedBox(
                      height: 150.0,
                      child: Loading(), // Your loading indicator widget
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showPokemonDialog(BuildContext context, Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: FutureBuilder<String>(
            future: imageUrl,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(snapshot.data!),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              // Display a progress indicator or placeholder while loading
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Circular clipping
                child: const SizedBox(
                  height: 150.0,
                  child: Loading(), // Your loading indicator widget
                ),
              );
            },
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Text(pokemon.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15,),
              Text(pokemon.description),
              const SizedBox(height: 20,),
              Text('Species: ${pokemon.species}', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Region: ${pokemon.region}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      Text('Type: ${pokemon.types}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              )
            ]
          ),
        );
      },
    );
  }
}