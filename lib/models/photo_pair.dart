import 'package:hive/hive.dart';

part 'photo_pair.g.dart';

@HiveType(typeId: 1)
class PhotoPair extends HiveObject {
  @HiveField(0)
  final String beforeImagePath;

  @HiveField(1)
  final String afterImagePath;

  PhotoPair({required this.beforeImagePath, required this.afterImagePath});
}
