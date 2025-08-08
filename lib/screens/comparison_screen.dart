import 'dart:io';
import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import '../models/photo_pair.dart';

class ComparisonScreen extends StatelessWidget {
  final PhotoPair pair;
  const ComparisonScreen({Key? key, required this.pair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare'),
      ),
      body: BeforeAfter(
        before: Image.file(File(pair.beforeImagePath)),
        after: Image.file(File(pair.afterImagePath)),
      ),
    );
  }
}
