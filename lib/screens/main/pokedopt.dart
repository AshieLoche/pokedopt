import 'package:flutter/material.dart';

class PokeDopt extends StatefulWidget {
  const PokeDopt({super.key});

  @override
  State<PokeDopt> createState() => _PokeDoptState();
}

class _PokeDoptState extends State<PokeDopt> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 52), // Adjust the width
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
                    onTap: () {
                      // Add your search functionality here
                    },
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Add your search functionality here
                      },
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  // Add your notification functionality here
                },
                child: IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    // Add your filter functionality here
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                PokemonCard(),
                PokemonCard(),
                PokemonCard(),
                PokemonCard(),
                PokemonCard(),
              ],
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
              Navigator.pushNamed(context, '/Profile'); // Navigate to profile page
              break;
            case 1:
            //palitan naten to from going to pokeDopt page it will refresh the homepage or go the upper screen
              Navigator.pushNamed(context, '/PokeDopt');
              break;
            case 2:
              Navigator.pushNamed(context, '/PokeList'); //Navigate to cart page
              break;
          // You can add cases for other tabs if needed
          }
        },
      ),
    );
  }
}


class PokemonCard extends StatefulWidget {
  const PokemonCard({super.key});

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
                  padding: const EdgeInsets.only(top: 7.0), // Add padding to the top
                  child: Container(
                    width: 250, // Adjust the width of the image container
                    height: 250, // Adjust the height of the image container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/pokemon/gengar.jpg'),
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0), // Adjust padding as needed
                  title: Text('Gengar'),
                  subtitle: Text(
                      'To steal the life of its target, it slips into the prey’s shadow and silently waits for an opportunity.'),
                ),
              ],
            ),
            Positioned(
              bottom: 8.0,
              left: 8.0,
              right: 8.0, // Positioned the button to stretch to the entire width of the card
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align the button to the right
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey, // Change color based on isLiked state
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked; // Toggle isLiked state
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