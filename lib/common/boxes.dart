import 'package:cloutbook/models/HiveWatchlistModel.dart';
import 'package:cloutbook/models/LoggedInUserModel.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<WatchProfile> getWatchProfileBox() =>
      Hive.box<WatchProfile>('watchProfile');
  static Box<LoggedInUser> getUserBox() => Hive.box<LoggedInUser>('users');
}
