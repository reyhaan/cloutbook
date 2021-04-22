import 'package:hive/hive.dart';

part 'HiveWatchlistModel.g.dart';

@HiveType(typeId: 0)
class WatchProfile extends HiveObject {
  @HiveField(0)
  late Map<String, dynamic>? profile;

  WatchProfile({
    this.profile,
  });
}
