class Pokemon {
  final String id;
  final String name;
  final String species;
  final String imageURL;
  final String description;
  final String types;
  final String region;

  Pokemon({
    required this.id,
    required this.name,
    required this.species,
    required this.imageURL,
    required this.description,
    required this.types,
    required this.region,
  });
}

class FavouritePokemon {
  final String userId;
  final String pokemonId;

  FavouritePokemon({
    required this.userId,
    required this.pokemonId,
  });
}