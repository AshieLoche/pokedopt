class Pokemon {
  final String name;
  final String species;
  final String imageURL;
  final String description;
  final String types;
  final String region;
  bool isLiked;

  Pokemon({
    required this.name,
    required this.species,
    required this.imageURL,
    required this.description,
    required this.types,
    required this.region,
    this.isLiked = false,
  });
}