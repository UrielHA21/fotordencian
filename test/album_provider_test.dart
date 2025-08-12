import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:fotordencian/models/album.dart';
import 'package:fotordencian/providers/album_provider.dart';
import 'package:fotordencian/services/database_service.dart';

void main() {
  late AlbumProvider provider;
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await DatabaseService().init();
  });

  setUp(() async {
    provider = AlbumProvider();
    await Future.delayed(Duration.zero);
  });

  tearDown(() async {
    await Hive.box<Album>('albums').clear();
  });

  tearDownAll(() async {
    await Hive.box<Album>('albums').close();
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  test('createAlbum adds a new album to the internal list', () async {
    expect(provider.albums, isEmpty);
    await provider.createAlbum('My Album');
    expect(provider.albums.length, 1);
    expect(provider.albums.first.name, 'My Album');
  });

  test('addPhotoPair stores pair under normalized date', () async {
    await provider.createAlbum('My Album');
    final date = DateTime(2023, 5, 10, 15, 30);
    await provider.addPhotoPair(
      albumName: 'My Album',
      date: date,
      pathBefore: 'before.jpg',
      pathAfter: 'after.jpg',
    );

    final album = provider.albums.firstWhere((a) => a.name == 'My Album');
    final normalizedDate = DateTime(date.year, date.month, date.day);

    expect(album.dates.containsKey(normalizedDate), isTrue);
    expect(album.dates[normalizedDate]!.length, 1);
    expect(album.dates.containsKey(date), isFalse);
  });
}
