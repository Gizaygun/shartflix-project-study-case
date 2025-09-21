import 'package:flutter/foundation.dart';

@immutable
class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String producer;
  final bool isFavorite;

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.producer,
    this.isFavorite = false,
  });

  Movie copyWith({
    String? id,
    String? title,
    String? posterUrl,
    String? producer,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      producer: producer ?? this.producer,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['title'] ?? 'Untitled',
      posterUrl: json['poster'] ?? '',
      producer: json['producer'] ?? 'Bilinmeyen Yapımcı',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster': posterUrl,
      'producer': producer,
      'isFavorite': isFavorite,
    };
  }
}
