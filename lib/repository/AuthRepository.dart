import 'package:cloutbook/common/boxes.dart';
import 'package:cloutbook/models/LoggedInUserModel.dart';
import 'package:injectable/injectable.dart';

abstract class BaseAuthRepository {
  Future<List<LoggedInUser>> getUsers();
  LoggedInUser getUserByName({required String username});
  LoggedInUser addUser({
    required LoggedInUser payload,
  });
  LoggedInUser updateUser({
    required LoggedInUser payload,
  });
  LoggedInUser? getLoggedInUser();
  Future<String> removeUser({
    required LoggedInUser payload,
  });
  bool isUserAlreadyAdded({
    required String username,
  });
  bool isUserAlreadyLoggedIn({
    required LoggedInUser payload,
  });
}

@lazySingleton
class AuthRepository extends BaseAuthRepository {
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
  LoggedInUser getUserByName({required username}) {
    try {
      final box = Boxes.getUserBox();
      // box.clear();
      LoggedInUser user = LoggedInUser.fromMap({});
      final list = box.values.toList();
      for (var i = 0; i < list.length; i++) {
        final data = list[i];
        if (data.username == username) {
          user = data;
        }
      }
      return user;
    } catch (e) {
      throw e;
    }
  }

  @override
  LoggedInUser? getLoggedInUser() {
    try {
      final box = Boxes.getUserBox();
      // box.clear();
      List<LoggedInUser> savedUsers = [];
      final list = box.values.toList();
      for (var i = 0; i < list.length; i++) {
        final data = list[i];
        savedUsers.add(data);
      }
      LoggedInUser? loggedInUser;
      savedUsers.forEach((user) {
        if (user.isLoggedIn) {
          loggedInUser = user;
        }
      });
      return loggedInUser;
    } catch (e) {
      throw e;
    }
  }

  @override
  LoggedInUser addUser({
    required LoggedInUser payload,
  }) {
    try {
      final box = Boxes.getUserBox();
      LoggedInUser newUser = payload;
      box.put(payload.username, newUser);
      return payload;
    } catch (e) {
      throw e;
    }
  }

  @override
  LoggedInUser updateUser({
    required LoggedInUser payload,
  }) {
    try {
      final box = Boxes.getUserBox();
      LoggedInUser newUser = payload;
      box.put(payload.username, newUser);
      return payload;
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
    required String username,
  }) {
    try {
      final box = Boxes.getUserBox();
      LoggedInUser? response = box.get(username);
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
