import 'package:cloutbook/models/ProfileModel.dart';
import 'package:hive/hive.dart';

part 'HiveWatchlistModel.g.dart';

@HiveType(typeId: 0)
class WatchProfile extends HiveObject {
  @HiveField(0)
  late ProfileEntryResponse? profile;

  WatchProfile({
    this.profile,
  });
}
