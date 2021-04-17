import 'dart:io';

import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/models/FailureModel.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class BaseHomeRepository {
  Future<List<Post>> getGlobalFeed({
    Map<String, dynamic>? payload,
  });
}

@lazySingleton
class HomeRepository extends BaseHomeRepository {
  final api = GetIt.I<ApiClient>();

  @override
  Future<List<Post>> getGlobalFeed({
    @required Map<String, dynamic>? payload,
  }) async {
    try {
      final queryParams = payload;

      final response = await api.post(
        '/get-posts-stateless',
        queryParams,
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
