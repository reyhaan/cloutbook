import 'package:cloutbook/models/HiveWatchlistModel.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<WatchProfile> getWatchProfileBox() =>
      Hive.box<WatchProfile>('watchProfile');
  static Box<WatchProfile> getUserBox() => Hive.box<WatchProfile>('users');
}
