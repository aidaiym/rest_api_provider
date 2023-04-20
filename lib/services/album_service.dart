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
}
