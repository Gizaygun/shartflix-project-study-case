class Movie {
  final int id;
  final String title;
  final String poster; // 300x450 görsel

  const Movie({
    required this.id,
    required this.title,
    required this.poster,
  });

  Movie copyWith({int? id, String? title, String? poster}) => Movie(
    id: id ?? this.id,
    title: title ?? this.title,
    poster: poster ?? this.poster,
  );

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'] as int,
    title: json['title'] as String,
    poster: json['poster'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'poster': poster,
  };
}
