class Photo {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String author;

  Photo({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['alt_description'] ?? '',
      imageUrl: json['urls']['regular'],
      description: json['description'] ?? '',
      author: json['user']['name'],
    );
  }
}
