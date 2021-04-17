import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:cloutbook/common/exceptions/exceptions.dart';
import 'package:cloutbook/constants/env.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class ApiClient {
  final Dio dio;
  final CancelToken token = CancelToken();

  ApiClient(this.dio) {
    dio.options.baseUrl = 'https://api.bitclout.com';
    dio.options.headers = {'Content-Type': 'application/json'};

    if (Platform.isAndroid || Platform.isIOS) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    if (Env.data['debugApiClient']!) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }

  Future<Response> post(
    String path,
    dynamic data,
  ) async {
    try {
      return await dio.post(path, data: data);
    } on DioError {
      throw ApiException();
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      return await dio.put(path, data: data);
    } on DioError {
      throw ApiException();
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await dio.delete(path);
    } on DioError {
      throw ApiException();
    }
  }

  Future<Response> get(String path) async {
    try {
      return await dio.get(path, cancelToken: token);
    } on DioError {
      throw ApiException();
    }
  }

  void clear() {
    return token.cancel('ALL GET REQUESTS CANCELLED!');
  }
}
