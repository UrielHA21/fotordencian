import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/photo_pair.dart';
import '../widgets/photo_pair_tile.dart';
import 'comparison_screen.dart';

class DayScreen extends StatelessWidget {
  final String albumName;
  final DateTime date;
  final List<PhotoPair> photoPairs;

  const DayScreen({
    Key? key,
    required this.albumName,
    required this.date,
    required this.photoPairs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat.yMMMd().format(date)),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: photoPairs.length,
        itemBuilder: (context, index) {
          final pair = photoPairs[index];
          return PhotoPairTile(
            pair: pair,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComparisonScreen(pair: pair),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
