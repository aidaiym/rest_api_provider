import 'dart:convert';

List<Album> fromStringList(String source) =>
    (jsonDecode(source) as List).map((e) => Album.fromMap(e)).toList();

class Album {
  const Album({
    required this.id,
    required this.title,
    required this.photo,
  });

  final int id;
  final String title;
  final String photo;

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'] as int,
      title: map['name'] as String,
      photo: map['photoUrl'] as String,
    );
  }
}
