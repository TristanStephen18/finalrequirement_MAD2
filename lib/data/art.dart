import 'package:hive/hive.dart';

part 'art.g.dart';

@HiveType(typeId: 0)
class Artwork {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String artist;

  @HiveField(2)
  late String date;

  @HiveField(3)
  late String imglocation;

  Artwork({
    required this.name,
    required this.artist,
    required this.date,
    required this.imglocation,
  });
}
