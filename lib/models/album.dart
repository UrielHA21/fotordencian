import 'package:hive/hive.dart';
import 'photo_pair.dart';

part 'album.g.dart';

@HiveType(typeId: 0)
class Album extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final Map<DateTime, List<PhotoPair>> dates;

  Album({required this.name, required this.dates});
}
