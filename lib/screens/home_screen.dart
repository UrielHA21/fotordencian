import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/album_provider.dart';
import '../widgets/album_card.dart';
import 'album_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Albums'),
      ),
      body: Consumer<AlbumProvider>(
        builder: (context, provider, child) {
          if (provider.albums.isEmpty) {
            return const Center(child: Text('No albums yet. Create one!'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: provider.albums.length,
            itemBuilder: (context, index) {
              final album = provider.albums[index];
              return AlbumCard(
                album: album,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlbumScreen(album: album),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateAlbumDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateAlbumDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Album'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Album Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Provider.of<AlbumProvider>(context, listen: false)
                      .createAlbum(controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
