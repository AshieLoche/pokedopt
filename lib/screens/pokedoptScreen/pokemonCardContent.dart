import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../models/pokemon.dart';

class PokemonCardContent extends StatelessWidget {

  final bool isLiked = false;
  final Pokemon pokemon;

  const PokemonCardContent({
    super.key,
    required this.pokemon,
  });

  Future<String> getImageURL(String imagePath) async {

    final storage = FirebaseStorage.instanceFor(bucket: 'gs://pokedopt-c3b3f.appspot.com');

    final imageRef = storage.ref().child(imagePath);

    try {
      final url = await imageRef.getDownloadURL();
      return url;
    } catch (error) {
      print('Error retrieving image URL: $error');
      // Handle error (e.g., display an error message to the user)
      return ''; // Or a placeholder URL
    }
  }



  @override
  Widget build(BuildContext context) {
    Future<String> imageUrl = getImageURL(pokemon.imageURL);

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
                    future: imageUrl,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            width: 250,
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
                      return const CircularProgressIndicator();
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
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   isLiked = !isLiked;
                      //   widget.onLiked(widget.pokemon); // Pass the entire Pokemon object
                      // });
                    },
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
