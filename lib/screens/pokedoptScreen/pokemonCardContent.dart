import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pokedopt/screens/pokelistScreen/pokelist.dart';
import '../../models/pokemon.dart';

class PokemonCardContent extends StatefulWidget {
  final Pokemon pokemon;
  final List<Pokemon> likedPokemonList;
  final Function(Pokemon, bool) onLiked; // Callback function

  const PokemonCardContent({
    Key? key,
    required this.pokemon,
    required this.likedPokemonList,
    required this.onLiked,
  }) : super(key: key);

  @override
  PokemonCardContentState createState() => PokemonCardContentState();
}

class PokemonCardContentState extends State<PokemonCardContent> {
  late Future<String> _imageUrl;
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _imageUrl = getImageURL(widget.pokemon.imageURL);
    // Initialize _isFavorited based on whether the pokemon is in likedPokemonList
    _isFavorited = widget.likedPokemonList.contains(widget.pokemon);
  }

  Future<String> getImageURL(String imagePath) async {
    final storage = FirebaseStorage.instanceFor(
        bucket: 'gs://pokedopt-c3b3f.appspot.com');
    final imageRef = storage.ref().child(imagePath);
    try {
      final url = await imageRef.getDownloadURL();
      return url;
    } catch (error) {
      // Handle error (e.g., display an error message to the user)
      return ''; // Or a placeholder URL
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
      widget.onLiked(widget.pokemon, _isFavorited); // Pass isLiked status
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: FutureBuilder<String>(
                    future: _imageUrl,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: 380,
                          height: 230,
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
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.pokemon.name,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.pokemon.description,
                            style: const TextStyle(fontSize: 15)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Species: ${widget.pokemon.species}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('Region: ${widget.pokemon.region}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('Type: ${widget.pokemon.types}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
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
                      _isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _isFavorited ? Colors.red : null,
                    ),
                    iconSize: 50,
                    onPressed: _toggleFavorite,
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
