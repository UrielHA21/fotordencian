import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/album.dart';
import '../models/photo_pair.dart';
import 'day_screen.dart';

class AlbumScreen extends StatelessWidget {
  final Album album;
  const AlbumScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dates = album.dates.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: Text(album.name),
      ),
      body: ListView.builder(
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final photoPairs = album.dates[date]!;
          return ListTile(
            title: Text(DateFormat.yMMMd().format(date)),
            subtitle: Text('${photoPairs.length} pairs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayScreen(
                    albumName: album.name,
                    date: date,
                    photoPairs: photoPairs,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final today = DateTime.now();
          // Crear un PhotoPair de ejemplo
          final newPhotoPair = PhotoPair(
            beforeImagePath: 'path/to/before_image.jpg',
            afterImagePath: 'path/to/after_image.jpg',
          );
          // Agregar el nuevo PhotoPair a la fecha actual
          album.dates[today] = album.dates[today] ?? [];
          album.dates[today]!.add(newPhotoPair);
          // Aquí podrías agregar lógica para actualizar la interfaz de usuario o guardar los cambios
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
