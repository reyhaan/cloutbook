import 'dart:convert';
import 'dart:io';

import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/common/boxes.dart';
import 'package:cloutbook/models/FailureModel.dart';
import 'package:cloutbook/models/HiveWatchlistModel.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/models/WalletModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class BaseExploreRepository {
  Future<List<ProfileEntryResponse>> getProfiles({
    Map<String, dynamic>? payload,
  });
  Future<List<Wallet>> getWallet({
    Map<String, dynamic>? payload,
  });
  Future<List<Wallet>> getBitCloutListWallet({
    String? payload,
  });
  Future<List<ProfileEntryResponse>> getWatchlist();
  Future<String> addToWatchlist({
    ProfileEntryResponse? payload,
  });
  Future<double> getHistory();
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
  Future<List<Wallet>> getWallet({
    @required Map<String, dynamic>? payload,
  }) async {
    try {
      final queryParams = payload;

      final response = await api.post(
        '/get-users-stateless',
        queryParams,
      );

      if (response.statusCode == 200) {
        List<Wallet> wallets = [];
        final data = Map<String, dynamic>.from(response.data);
        final _wallets =
            List<Map<String, dynamic>>.from(data['UserList'] ?? []);

        _wallets.forEach((wallet) {
          wallets.add(Wallet.fromMap(wallet));
        });

        return wallets;
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    } on Error catch (err) {
      print(err);
      throw err;
    }
  }

  @override
  Future<List<Wallet>> getBitCloutListWallet({
    @required String? payload,
  }) async {
    try {
      final response = await api.get(
        'https://bitcloutlistback.azurewebsites.net/explorer/getholdings/$payload',
      );

      if (response.statusCode == 200) {
        List<Wallet> wallets = [];
        final data = Map<String, dynamic>.from(response.data);
        final _wallets =
            List<Map<String, dynamic>>.from(data['UserList'] ?? []);

        _wallets.forEach((wallet) {
          wallets.add(Wallet.fromMap(wallet));
        });

        return wallets;
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    } on Error catch (err) {
      print(err);
      throw err;
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
  Future<double> getHistory({publicKey}) async {
    try {
      final response = await api.get(
        'https://www.bitcloutpulse.com/profiles/$publicKey?timeframe=1day',
      );

      if (response.statusCode == 200) {
        final _ticker = response.data;
        String tickerValue = _ticker!.toString();
        RegExp regExp = new RegExp(r'(?<=\bdata-react-props=\")[^"]*');
        var matches = regExp.allMatches(tickerValue);

        if (matches.length > 0) {
          RegExpMatch match = matches.elementAt(0);
          String matchedString = match.group(0)!.replaceAll("&quot;", "\"");
          final history = json.decode(matchedString);
          final first = double.parse(
              List<Map<String, dynamic>>.from(history['chartData'])
                  .first['value']);
          final last = double.parse(
              List<Map<String, dynamic>>.from(history['chartData'])
                  .last['value']);

          print(first);
          print(last);

          double percentage = 0;

          if (last < first) {
            // calculate decrease
            double decrease = first - last;
            percentage = -(decrease / first) * 100;
          } else {
            // calculate increase
            double increase = last - first;
            percentage = (increase / first) * 100;
          }

          return percentage;
        }
      }
      return 0;
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    } on Error catch (err) {
      print(err);
      throw err;
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
