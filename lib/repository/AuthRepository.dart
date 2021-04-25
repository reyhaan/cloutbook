import 'package:cloutbook/common/boxes.dart';
import 'package:cloutbook/models/HiveWatchlistModel.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class BaseExploreRepository {
  Future<List<ProfileEntryResponse>> getUsers();
  Future<String> addUser({
    ProfileEntryResponse? payload,
  });
  Future<String> removeUser({
    ProfileEntryResponse? payload,
  });
  bool isUserAlreadyAdded({
    ProfileEntryResponse? payload,
  });
}

@lazySingleton
class ExploreRepository extends BaseExploreRepository {
  @override
  Future<List<ProfileEntryResponse>> getUsers() async {
    try {
      final box = Boxes.getUserBox();
      // box.clear();
      List<ProfileEntryResponse> savedProfiles = [];
      final list = box.values.toList();
      for (var i = 0; i < list.length; i++) {
        final data = list[i];
        savedProfiles.add(ProfileEntryResponse.fromMap(
            data.profile!.cast<String, dynamic>()));
      }
      return Future.value(savedProfiles);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> addUser({
    @required ProfileEntryResponse? payload,
  }) {
    try {
      final box = Boxes.getUserBox();
      WatchProfile newProfile = WatchProfile(profile: payload?.toJson());
      box.put(payload?.username, newProfile);
      return Future.value(payload?.username);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> removeUser({
    @required ProfileEntryResponse? payload,
  }) async {
    try {
      final box = Boxes.getUserBox();
      await box.delete(payload?.username);
      return Future.value(payload?.username);
    } catch (e) {
      throw e;
    }
  }

  @override
  bool isUserAlreadyAdded({
    @required ProfileEntryResponse? payload,
  }) {
    try {
      final box = Boxes.getUserBox();
      WatchProfile? response = box.get(payload?.username);
      if (response != null) {
        if (ProfileEntryResponse.fromMap(response.profile!).username != null) {
          return true;
        }
      }
      return false;
    } catch (e) {
      throw e;
    }
  }
}
