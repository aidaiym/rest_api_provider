import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_provider/providers/album_provider.dart';

import '../models/album_model.dart';
import '../services/album_service.dart';

class AddAlbumView extends StatefulWidget {
  const AddAlbumView({super.key});

  @override
  _AddAlbumViewState createState() => _AddAlbumViewState();
}

class _AddAlbumViewState extends State<AddAlbumView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newAlbum = Album(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: _titleController.text,
                      photo: _imageController.text,
                    );
                    await AlbumService.addAlbum(newAlbum);
                    Provider.of<AlbumProvider>(context, listen: false)
                        .addItem(newAlbum);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}
