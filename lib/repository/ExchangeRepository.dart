import 'dart:io';

import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/models/FailureModel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class BaseExchangeRepository {
  Future<Map<String, dynamic>> getExchangeRate();
  Future<Map<String, dynamic>> getTicker();
}

@lazySingleton
class ExchangeRepository extends BaseExchangeRepository {
  final api = GetIt.I<ApiClient>();

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
