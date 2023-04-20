import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_provider/providers/album_provider.dart';
import 'package:rest_api_provider/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AlbumProvider(),
      child: const MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
