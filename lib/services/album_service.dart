import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:rest_api_provider/constants/api_const.dart';
import '../models/album_model.dart';

class AlbumService {
  Future<List<Album>> getAlbum() async {
    try {
      final uri = Uri.parse(ApiConst.albums);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        final albums = json.map((e) {
          return Album(
            id: e['id'],
            title: e['title'],
            photo: e['url'],
          );
        }).toList();
        return albums;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<void> addAlbum(Album newAlbum) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConst.albums),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newAlbum.toJson()),
      );
      if (response.statusCode == 201) {
        log('Item added successfully');
      } else {
        log('Failed to add item: ${response.statusCode}');
      }
    } catch (e) {
      log('Failed to connect to the server: $e');
    }
  }
}
