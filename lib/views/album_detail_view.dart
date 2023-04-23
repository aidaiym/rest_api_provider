import 'package:flutter/material.dart';

import '../models/album_model.dart';

class AlbumDetailView extends StatelessWidget {
  const AlbumDetailView({super.key, required this.album});
  final Album album;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(album.title)),
      body: Column(
        children: [
          Hero(
            tag: album.id,
            child: Image.network(album.photo),
          ),
          Text(album.title)
        ],
      ),
    );
  }
}
