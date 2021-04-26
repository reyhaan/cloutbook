import 'package:cloutbook/common/boxes.dart';
import 'package:cloutbook/models/LoggedInUserModel.dart';
import 'package:injectable/injectable.dart';

abstract class BaseExploreRepository {
  Future<List<LoggedInUser>> getUsers();
  Future<String> addUser({
    required LoggedInUser payload,
  });
  Future<String> removeUser({
    required LoggedInUser payload,
  });
  bool isUserAlreadyAdded({
    required LoggedInUser payload,
  });
  bool isUserAlreadyLoggedIn({
    required LoggedInUser payload,
  });
}

@lazySingleton
class ExploreRepository extends BaseExploreRepository {
  @override
  Future<List<LoggedInUser>> getUsers() async {
    try {
      final box = Boxes.getUserBox();
      // box.clear();
      List<LoggedInUser> savedUsers = [];
      final list = box.values.toList();
      for (var i = 0; i < list.length; i++) {
        final data = list[i];
        savedUsers.add(data);
      }
      return Future.value(savedUsers);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> addUser({
    required LoggedInUser payload,
  }) {
    try {
      final box = Boxes.getUserBox();
      LoggedInUser newUser = payload;
      box.put(payload.username, newUser);
      return Future.value(payload.username);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> removeUser({
    required LoggedInUser payload,
  }) async {
    try {
      final box = Boxes.getUserBox();
      await box.delete(payload.username);
      return Future.value(payload.username);
    } catch (e) {
      throw e;
    }
  }

  @override
  bool isUserAlreadyAdded({
    required LoggedInUser payload,
  }) {
    try {
      final box = Boxes.getUserBox();
      LoggedInUser? response = box.get(payload.username);
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      throw e;
    }
  }

  @override
  bool isUserAlreadyLoggedIn({
    required LoggedInUser payload,
  }) {
    try {
      final box = Boxes.getUserBox();
      LoggedInUser? response = box.get(payload.username);
      if (response != null) {
        if (response.isLoggedIn) {
          return true;
        }
      }
      return false;
    } catch (e) {
      throw e;
    }
  }
}
