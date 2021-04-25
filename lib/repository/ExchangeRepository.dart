import 'dart:convert';
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
  Future<Map<String, dynamic>> getHistory();
  Future<bool> dispose();
}

final HeadlessInAppWebView? bitCloutWebView = new HeadlessInAppWebView(
  initialUrlRequest: URLRequest(url: Uri.parse("https://api.bitclout.com/get-exchange-rate")),
  initialOptions: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(),
  ),
  onLoadStop: (controller, url) async {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    final String getExchangeRateFunction = """
        var exchangeRate = await fetch("https://api.bitclout.com/get-exchange-rate");
        var x = await exchangeRate.json();
        return x;
        """;
    var _exchangeRate = await controller.callAsyncJavaScript(functionBody: getExchangeRateFunction, arguments: {});

    Map<String, dynamic> exchangeValue = _exchangeRate!.toMap().cast<String, dynamic>();

    ExchangeRate exchangeRate = ExchangeRate.fromMap(exchangeValue['value'].cast<String, dynamic>());
    _exchangeStore.setExchangeRate(exchangeRate);
  },
);

final HeadlessInAppWebView? tickerWebView = new HeadlessInAppWebView(
  initialUrlRequest: URLRequest(url: Uri.parse("https://blockchain.info/ticker")),
  initialOptions: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(),
  ),
  onLoadStop: (controller, url) async {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    final String getTickerFunction = """
        var ticker = await fetch("https://blockchain.info/ticker");
        var y = await ticker.json();
        return y;
        """;
    var _ticker = await controller.callAsyncJavaScript(functionBody: getTickerFunction, arguments: {});

    Map<String, dynamic> tickerValue = _ticker!.toMap().cast<String, dynamic>();

    Ticker ticker = Ticker.fromMap(tickerValue['value'].cast<String, dynamic>());
    _exchangeStore.setTicker(ticker);
  },
);

final HeadlessInAppWebView? historyWebView = HeadlessInAppWebView(
  initialUrlRequest: URLRequest(
      url: Uri.parse(
          "https://www.bitcloutpulse.com/profiles/BC1YLg4UKP7n7fasm4nH4ngxhDZjG5AKE87LmUtyeLTuBwzXFtu383X?timeframe=1day")),
  initialOptions: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(),
  ),
  onLoadStop: (controller, url) async {
    var _ticker = await controller.getHtml();
    String tickerValue = _ticker!.toString();
    RegExp regExp = new RegExp(r'(?<=\bdata-react-props=\")[^"]*');
    var matches = regExp.allMatches(tickerValue);

    if (matches.length > 0) {
      RegExpMatch match = matches.elementAt(0);
      String matchedString = match.group(0)!.replaceAll("&quot;", "\"");
      print(json.decode(matchedString));
    }
  },
);

@lazySingleton
class ExchangeRepository extends BaseExchangeRepository {
  final api = GetIt.I<ApiClient>();

  @override
  Future<bool> dispose() async {
    // await tickerWebView?.dispose();
    // await bitCloutWebView?.dispose();
    return true;
  }

  @override
  Future<Map<String, dynamic>> getExchangeRate() async {
    try {
      await bitCloutWebView?.dispose();
      await bitCloutWebView?.run();
      return {};
    } on DioError catch (err) {
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
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
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      throw Failure(message: 'Please check your connection.');
    }
  }

  @override
  Future<Map<String, dynamic>> getHistory({publicKey}) async {
    try {
      await historyWebView?.dispose();
      await historyWebView?.run();
      return {};
    } on DioError catch (err) {
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      throw Failure(message: 'Please check your connection.');
    }
  }
}
