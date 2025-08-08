import 'package:flutter/foundation.dart';
import '../models/album.dart';
import '../models/photo_pair.dart';
import '../services/database_service.dart';

class AlbumProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  List<Album> _albums = [];
  List<Album> get albums => _albums;

  AlbumProvider() {
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    _albums = _databaseService.getAllAlbums();
    notifyListeners();
  }

  Future<void> createAlbum(String name) async {
    final newAlbum = Album(name: name, dates: {});
    await _databaseService.saveAlbum(newAlbum);
    _albums.add(newAlbum);
    notifyListeners();
  }

  Future<void> addPhotoPair({
    required String albumName,
    required DateTime date,
    required String pathBefore,
    required String pathAfter,
  }) async {
    final newPair = PhotoPair(beforeImagePath: pathBefore, afterImagePath: pathAfter);
    await _databaseService.addPhotoPair(albumName, date, newPair);
    // This requires a more complex update than just adding to the list
    // For now, just reload all albums to reflect the change
    await _loadAlbums();
  }

  Future<void> deletePhotoPair({
    required String albumName,
    required DateTime date,
    required PhotoPair pair,
  }) async {
    await _databaseService.deletePhotoPair(albumName, date, pair);
    await _loadAlbums();
  }
}
