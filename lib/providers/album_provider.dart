import 'package:flutter/material.dart';

import '../models/album_model.dart';
import '../services/album_service.dart';

class AlbumProvider extends ChangeNotifier {
  final _service = AlbumService();
  bool isLoading = false;
  List<Album> _album = [];
  List<Album> get album => _album;

  Future<void> getDatas() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAlbum();
    _album = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
    _album;
    notifyListeners();
  }

  void addItem(Album newItem) {
    _album.add(newItem);
    notifyListeners();
  }

  void removeItem(int index) {
    _album.removeAt(index);
    notifyListeners();
  }
}
