import 'dart:io';

import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/common/boxes.dart';
import 'package:cloutbook/models/FailureModel.dart';
import 'package:cloutbook/models/HiveWatchlistModel.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class BaseExploreRepository {
  Future<List<ProfileEntryResponse>> getProfiles({
    Map<String, dynamic>? payload,
  });
  Future<List<ProfileEntryResponse>> getWatchlist();
  Future<String> addToWatchlist({
    ProfileEntryResponse? payload,
  });
  Future<String> removeFromWatchlist({
    ProfileEntryResponse? payload,
  });
  bool isInWatchlist({
    ProfileEntryResponse? payload,
  });
}

@lazySingleton
class ExploreRepository extends BaseExploreRepository {
  final api = GetIt.I<ApiClient>();

  @override
  Future<List<ProfileEntryResponse>> getProfiles({
    @required Map<String, dynamic>? payload,
  }) async {
    try {
      final queryParams = payload;

      final response = await api.post(
        '/get-profiles',
        queryParams,
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results =
            List<Map<String, dynamic>>.from(data['ProfilesFound'] ?? []);

        if (results.isNotEmpty) {
          return results.map((e) => ProfileEntryResponse.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  @override
  Future<List<ProfileEntryResponse>> getWatchlist() async {
    try {
      final box = Boxes.getWatchProfileBox();
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
  Future<String> addToWatchlist({
    @required ProfileEntryResponse? payload,
  }) {
    try {
      final box = Boxes.getWatchProfileBox();
      WatchProfile newProfile = WatchProfile(profile: payload?.toJson());
      box.put(payload?.username, newProfile);
      return Future.value(payload?.username);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> removeFromWatchlist({
    @required ProfileEntryResponse? payload,
  }) async {
    try {
      final box = Boxes.getWatchProfileBox();
      await box.delete(payload?.username);
      return Future.value(payload?.username);
    } catch (e) {
      throw e;
    }
  }

  @override
  bool isInWatchlist({
    @required ProfileEntryResponse? payload,
  }) {
    try {
      final box = Boxes.getWatchProfileBox();
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
