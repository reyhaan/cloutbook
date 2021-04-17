import 'dart:io';

import 'package:cloutbook/models/FailureModel.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider<Dio>(
    (ref) => Dio(BaseOptions(headers: {'Content-Type': 'application/json'})));

final homeRepositoryProvider =
    Provider<HomeRepository>((ref) => HomeRepository(ref.read));

abstract class BaseHomeRepository {
  Future<List<Post>> getGlobalFeed({
    Map<String, dynamic>? payload,
  });
}

class HomeRepository extends BaseHomeRepository {
  final Reader _read;

  HomeRepository(this._read);

  @override
  Future<List<Post>> getGlobalFeed({
    @required Map<String, dynamic>? payload,
  }) async {
    try {
      final queryParams = payload;

      final response = await _read(dioProvider).post(
        'https://api.bitclout.com/get-posts-stateless',
        data: queryParams,
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results =
            List<Map<String, dynamic>>.from(data['PostsFound'] ?? []);

        if (results.isNotEmpty) {
          return results.map((e) => Post.fromMap(e)).toList();
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
}
