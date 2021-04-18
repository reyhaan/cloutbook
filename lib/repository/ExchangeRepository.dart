import 'dart:io';

import 'package:cloutbook/common/api_client/api_client.dart';
import 'package:cloutbook/models/ExchangeRateModel.dart';
import 'package:cloutbook/models/FailureModel.dart';
import 'package:cloutbook/models/TickerModel.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class BaseExchangeRepository {
  Future<Map<String, dynamic>> getExchangeRate();
  Future<Map<String, dynamic>> getTicker();
  Future<bool> dispose();
}

final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();

final HeadlessInAppWebView? bitCloutWebView = new HeadlessInAppWebView(
  initialUrlRequest:
      URLRequest(url: Uri.parse("https://api.bitclout.com/get-exchange-rate")),
  initialOptions: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(),
  ),
  onLoadStop: (controller, url) async {
    final String getExchangeRateFunction = """
        var exchangeRate = await fetch("https://api.bitclout.com/get-exchange-rate");
        var x = await exchangeRate.json();
        return x;
        """;
    var _exchangeRate = await controller.callAsyncJavaScript(
        functionBody: getExchangeRateFunction, arguments: {});

    ExchangeRate exchangeRate = ExchangeRate.fromMap(_exchangeRate?.value);
    _exchangeStore.setExchangeRate(exchangeRate);
  },
);

final HeadlessInAppWebView? tickerWebView = new HeadlessInAppWebView(
  initialUrlRequest:
      URLRequest(url: Uri.parse("https://blockchain.info/ticker")),
  initialOptions: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(),
  ),
  onLoadStop: (controller, url) async {
    final String getTickerFunction = """
        var ticker = await fetch("https://blockchain.info/ticker");
        var y = await ticker.json();
        return y;
        """;
    var _ticker = await controller
        .callAsyncJavaScript(functionBody: getTickerFunction, arguments: {});

    Ticker ticker = Ticker.fromMap(_ticker?.value);
    _exchangeStore.setTicker(ticker);
  },
);

@lazySingleton
class ExchangeRepository extends BaseExchangeRepository {
  final api = GetIt.I<ApiClient>();

  @override
  Future<bool> dispose() async {
    await tickerWebView?.dispose();
    await bitCloutWebView?.dispose();
    return true;
  }

  @override
  Future<Map<String, dynamic>> getExchangeRate() async {
    try {
      await bitCloutWebView?.dispose();
      await bitCloutWebView?.run();
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
      await tickerWebView?.dispose();
      await tickerWebView?.run();
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
