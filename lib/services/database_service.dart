import 'package:hive/hive.dart';
import '../models/album.dart';
import '../models/photo_pair.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  late Box<Album> _albumBox;

  Future<void> init() async {
    // Register adapters only once to avoid Hive errors on hot reload
    if (!Hive.isAdapterRegistered(AlbumAdapter().typeId)) {
      Hive.registerAdapter(AlbumAdapter());
    }
    if (!Hive.isAdapterRegistered(PhotoPairAdapter().typeId)) {
      Hive.registerAdapter(PhotoPairAdapter());
    }

    // Open boxes
    _albumBox = await Hive.openBox<Album>('albums');
  }

  Future<void> saveAlbum(Album album) async {
    await _albumBox.put(album.name, album);
  }

  List<Album> getAllAlbums() {
    return _albumBox.values.toList();
  }

  Future<void> addPhotoPair(String albumName, DateTime date, PhotoPair pair) async {
    final album = _albumBox.get(albumName);
    if (album != null) {
      if (album.dates.containsKey(date)) {
        album.dates[date]!.add(pair);
      } else {
        album.dates[date] = [pair];
      }
      await album.save();
    }
  }

  Future<void> deletePhotoPair(String albumName, DateTime date, PhotoPair pair) async {
    final album = _albumBox.get(albumName);
    if (album != null && album.dates.containsKey(date)) {
      album.dates[date]!.remove(pair);
      if (album.dates[date]!.isEmpty) {
        album.dates.remove(date);
      }
      await album.save();
    }
  }
}
