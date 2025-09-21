import 'package:flutter/foundation.dart';

@immutable
class AppUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? token;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.token,
  });

  factory AppUser.fromLoginData(Map<String, dynamic> data) {
    final id = (data['id'] ?? data['_id'] ?? '').toString();
    return AppUser(
      id: id,
      name: (data['name'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
      photoUrl: (data['photoUrl'] ?? '').toString().isEmpty
          ? null
          : (data['photoUrl'] as String),
      token: (data['token'] ?? '').toString().isEmpty
          ? null
          : (data['token'] as String),
    );
  }

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? token,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
    'token': token,
  };
}
