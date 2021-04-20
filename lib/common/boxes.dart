import 'package:cloutbook/models/HiveWatchlistModel.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<WatchProfile> getWatchlistBox() =>
      Hive.box<WatchProfile>('watchProfile');
}
