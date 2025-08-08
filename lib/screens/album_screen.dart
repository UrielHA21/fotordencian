import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/album.dart';
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
          // For simplicity, we'll add a pair to the current date.
          // A more robust implementation would use a date picker.
          final today = DateTime.now();
          // TODO: Implement image picking and adding a new pair
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
