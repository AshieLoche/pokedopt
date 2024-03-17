import 'package:flutter/material.dart';

class Pokemon {
  final String name;
  final String imageUrl;
  final String description;

  Pokemon({required this.name, required this.imageUrl,required this.description});
}

class PokemonCard extends StatefulWidget {
  final Pokemon pokemon;
  final Function(String) onLiked;
  final String description;

  const PokemonCard({Key? key, required this.pokemon, required this.onLiked,required this.description})
      : super(key: key);

  @override
  PokemonCardState createState() => PokemonCardState();
}

class PokemonCardState extends State<PokemonCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.pokemon.imageUrl),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
                  title: Text(widget.pokemon.name),
                  subtitle: Text(widget.pokemon.description), // Display the dynamic description
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
                      setState(() {
                        isLiked = !isLiked;
                        widget.onLiked(widget.pokemon.name);
                      });
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

class PokeDopt extends StatefulWidget {
  final List<String> likedPokemons;

  const PokeDopt({Key? key, required this.likedPokemons}) : super(key: key);


  @override
  PokeDoptState createState() => PokeDoptState();
}

class PokeDoptState extends State<PokeDopt> {
  List<String> likedPokemons = [];


  final List<Pokemon> pokemons = [
    Pokemon(name: 'Gengar', imageUrl: 'assets/pokemon/gengar.jpg',description: 'To steal the life of its target, it slips into the prey’s shadow and silently waits for an opportunity.'),
    Pokemon(name: 'Dragonite', imageUrl: 'assets/pokemon/dragonite.jpg',description: 'It is said that somewhere in the ocean lies an island where these gather. Only they live there.'),
    Pokemon(name: 'Chandelure', imageUrl: 'assets/pokemon/chandelure.jpg',description: 'The spirits burned up in its ominous flame lose their way and wander this world forever.'),
    // Add more Pokemon data here
  ];

  // Function to update likedPokemons list
  void updateLikedPokemons(String pokemonName) {
    setState(() {
      if (!likedPokemons.contains(pokemonName)) {
        likedPokemons.add(pokemonName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 52),
            ImageIcon(AssetImage('assets/pokedopt.ico')),
            SizedBox(width: 3),
            Text('PokeDopt'),
            SizedBox(width: 1),
          ],
        ),
        actions: const [
          SizedBox(width: 48),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                return PokemonCard(
                  pokemon: pokemon,
                  onLiked: (String pokemonName) {
                    setState(() {
                      if (!likedPokemons.contains(pokemonName)) {
                        likedPokemons.add(pokemonName);
                      }
                    });
                  },
                  description: pokemon.description, // Pass the description here
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.orange),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/pokedopt.ico'), color: Colors.orange),
            label: 'PokeHome',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/pokepals.ico'), color: Colors.orange),
            label: 'PokeList',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/Profile');
              break;
            case 1:
              Navigator.pushNamed(context, '/PokeHome');
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokeListPage(likedPokemons: likedPokemons),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class PokeListPage extends StatelessWidget {
  final List<String> likedPokemons;

  const PokeListPage({Key? key, required this.likedPokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeList Pages'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: likedPokemons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(likedPokemons[index]),
            leading: Image.asset(
                'assets/pokemon/${likedPokemons[index].toLowerCase()}.jpg'),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.orange),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/pokedopt.ico'), color: Colors.orange),
            label: 'PokeDopt',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/pokepals.ico'), color: Colors.orange),
            label: 'PokeList',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/Profile');
              break;
            case 1:
              Navigator.pushNamed(context, '/PokeDopt');
              break;
            case 2:
              Navigator.pushNamed(context, '/PokeList');
              break;
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> likedPokemons = [];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokeDopt',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => PokeDopt(likedPokemons: likedPokemons),
        '/profile': (context) => PokeDopt(likedPokemons: likedPokemons),
        '/PokeHome': (context) => PokeDopt(likedPokemons: likedPokemons),
        '/PokeList': (context) => PokeListPage(likedPokemons: likedPokemons),
      },
    );
  }
}

