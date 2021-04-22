import 'dart:io';

import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/models/FailureModel.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class BaseProfileRepository {
  Future<ProfileEntryResponse> getUserProfile({
    Map<String, dynamic>? payload,
  });
  Future<List<Post>> getPostsForPublicKey({
    required Map<String, dynamic> payload,
    required ProfileEntryResponse profile,
  });
  Future<int> getFollowers({
    Map<String, dynamic>? payload,
  });
  Future<Map<String, dynamic>> getExchangeRate();
  Future<Map<String, dynamic>> getTicker();
}

@lazySingleton
class ProfileRepository extends BaseProfileRepository {
  final api = GetIt.I<ApiClient>();

  @override
  Future<ProfileEntryResponse> getUserProfile({
    @required Map<String, dynamic>? payload,
  }) async {
    try {
      final queryParams = payload;

      final response = await api.post(
        '/get-single-profile',
        queryParams,
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        return ProfileEntryResponse.fromMap(data['Profile']);
      }
      return ProfileEntryResponse(posts: []);
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  @override
  Future<List<Post>> getPostsForPublicKey({
    required Map<String, dynamic> payload,
    required ProfileEntryResponse profile,
  }) async {
    try {
      final queryParams = payload;

      final response = await api.post(
        '/get-posts-for-public-key',
        queryParams,
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        List<Map<String, dynamic>> posts =
            List<Map<String, dynamic>>.from(data['Posts']);
        List<Post> result = [];

        posts.forEach((post) {
          post['ProfileEntryResponse'] = profile.toJson();
          result.add(Post.fromMap(post));
        });

        return result;
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
  Future<int> getFollowers({
    @required Map<String, dynamic>? payload,
  }) async {
    try {
      final queryParams = payload;

      final response = await api.post(
        '/get-follows-stateless',
        queryParams,
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        return data['NumFollowers'];
      }
      return 0;
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  @override
  Future<Map<String, dynamic>> getExchangeRate() async {
    try {
      final response = await api.get('/get-exchange-rate');
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        return data;
      }
      return {};
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  @override
  Future<Map<String, dynamic>> getTicker() async {
    try {
      final response = await api.get('https://blockchain.info/ticker');
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        return data;
      }
      return {};
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }
}
