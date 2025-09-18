class User {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json["id"] ?? json["_id"] ?? "").toString(),
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      photoUrl: json["photoUrl"],
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
