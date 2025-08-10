import 'dart:io';
import 'package:flutter/material.dart';
import '../models/photo_pair.dart';

class PhotoPairTile extends StatelessWidget {
  final PhotoPair pair;
  final VoidCallback onTap;

  const PhotoPairTile({
    Key? key,
    required this.pair,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GridTile(
        child: Row(
          children: [
            Expanded(child: Image.file(File(pair.beforeImagePath), fit: BoxFit.cover)),
            Expanded(child: Image.file(File(pair.afterImagePath), fit: BoxFit.cover)),
          ],
        ),
      ),
    );
  }
}
