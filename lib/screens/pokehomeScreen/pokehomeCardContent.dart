import 'package:flutter/material.dart';
import 'package:pokedopt/services/databaseService.dart';
import 'package:pokedopt/shared/loading.dart';
import 'package:provider/provider.dart';
import '../../models/pokemon.dart';
import '../../models/user.dart';

class PokeHomeCardContent extends StatefulWidget {

  final Pokemon pokemon;
  const PokeHomeCardContent({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokeHomeCardContent> createState() => _PokeHomeCardContentState();
}

class _PokeHomeCardContentState extends State<PokeHomeCardContent> {

  late Pokemon pokemon;
  late bool _isFavourited;

  @override
  void initState() {
    super.initState();
    _isFavourited = false;
    pokemon = widget.pokemon;
  }

  @override
  Widget build(BuildContext context) {
    Future<String> imageUrl = DatabaseService().getImageURL(pokemon.imageURL);
    final user = Provider.of<User?>(context);
    final favourites = Provider.of<List<FavouritePokemon>>(context);

    for (var favourite in favourites) {
      if (pokemon.id == favourite.pokemonId) {
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
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: FutureBuilder<String>(
                    future: imageUrl,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: 380,
                          height: 250,
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
                          width: 380.0,
                          height: 250.0,
                          child: Loading(), // Your loading indicator widget
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pokemon.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15,),
                      Text(pokemon.description),
                      const SizedBox(height: 20,),
                      Text('Species: ${pokemon.species}', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                      Text('Region: ${pokemon.region}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      Text('Type: ${pokemon.types}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      await DatabaseService(uid: user!.uid).updateFavouriteData(pokemon.id, pokemon.name, _isFavourited);
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}