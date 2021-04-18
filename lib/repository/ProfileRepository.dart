import 'dart:io';

import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/models/FailureModel.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class BaseProfileRepository {
  Future<ProfileEntryResponse> getUserProfile({
    Map<String, dynamic>? payload,
  });
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
        '/get-profiles',
        queryParams,
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        return ProfileEntryResponse.fromMap(data['ProfilesFound'][0]);
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
}
