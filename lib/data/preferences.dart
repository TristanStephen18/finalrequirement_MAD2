import 'package:hive/hive.dart';
import 'package:moseum_application_rasco/data/art.dart';

part 'preferences.g.dart';

@HiveType(typeId: 2)
class Preferences{
  @HiveField(0)
  List<Artwork> pref = [];

  Preferences({
    required this.pref
  });
}