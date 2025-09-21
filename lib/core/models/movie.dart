class Movie {
  final String id;
  final String title;
  final String? subtitle;
  final String? posterUrl;
  final String? description;
  final bool isFavorite;

  const Movie({
    required this.id,
    required this.title,
    this.subtitle,
    this.posterUrl,
    this.description,
    this.isFavorite = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled',
      subtitle: json['subtitle']?.toString(),
      posterUrl: (json['poster'] ?? json['posterUrl'])?.toString(),
      description: json['description']?.toString(),
      isFavorite: json['isFavorite'] == true,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'posterUrl': posterUrl,
    'description': description,
    'isFavorite': isFavorite,
  };

  Movie copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? posterUrl,
    String? description,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      posterUrl: posterUrl ?? this.posterUrl,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
