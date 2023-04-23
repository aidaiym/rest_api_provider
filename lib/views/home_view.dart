import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_provider/views/album_detail_view.dart';
import '../models/album_model.dart';
import '../providers/album_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AlbumProvider>(context, listen: false).getDatas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Provider API'),
      ),
      // RefreshIndicator - The ability to refresh the list of items by pulling down on the list.
      body: RefreshIndicator(
        onRefresh: () => context.read<AlbumProvider>().refreshList(),
        child: Consumer<AlbumProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final albums = value.album;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                // Dismissible -  The ability to delete an item from the list by swiping left on an item in the list.
                return Dismissible(
                  key: Key(album.toString()),
                  onDismissed: (direction) {
                    AlbumProvider().removeItem(index);
                  },
                  background: Container(color: Colors.red),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumDetailView(album: album),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.network(album.photo),
                      ),
                      title: Text(
                        album.title,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final Album newItem;
              return AlertDialog(
                title: const Text('Add new item'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // context.read<AlbumProvider>().addItem(newItem);
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
