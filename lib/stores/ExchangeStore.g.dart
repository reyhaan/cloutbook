// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExchangeStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ExchangeStore on _ExchangeStore, Store {
  final _$exchangeRateAtom = Atom(name: '_ExchangeStore.exchangeRate');

  @override
  ExchangeRate get exchangeRate {
    _$exchangeRateAtom.reportRead();
    return super.exchangeRate;
  }

  @override
  set exchangeRate(ExchangeRate value) {
    _$exchangeRateAtom.reportWrite(value, super.exchangeRate, () {
      super.exchangeRate = value;
    });
  }

  final _$tickerAtom = Atom(name: '_ExchangeStore.ticker');

  @override
  Ticker get ticker {
    _$tickerAtom.reportRead();
    return super.ticker;
  }

  @override
  set ticker(Ticker value) {
    _$tickerAtom.reportWrite(value, super.ticker, () {
      super.ticker = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ExchangeStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$disposeWebViewsAsyncAction =
      AsyncAction('_ExchangeStore.disposeWebViews');

  @override
  Future<bool> disposeWebViews() {
    return _$disposeWebViewsAsyncAction.run(() => super.disposeWebViews());
  }

  final _$getExchangeRateAsyncAction =
      AsyncAction('_ExchangeStore.getExchangeRate');

  @override
  Future<bool> getExchangeRate() {
    return _$getExchangeRateAsyncAction.run(() => super.getExchangeRate());
  }

  final _$getTickerAsyncAction = AsyncAction('_ExchangeStore.getTicker');

  @override
  Future<bool> getTicker() {
    return _$getTickerAsyncAction.run(() => super.getTicker());
  }

  final _$updateExchangeAsyncAction =
      AsyncAction('_ExchangeStore.updateExchange');

  @override
  Future<void> updateExchange() {
    return _$updateExchangeAsyncAction.run(() => super.updateExchange());
  }

  final _$_ExchangeStoreActionController =
      ActionController(name: '_ExchangeStore');

  @override
  void reset() {
    final _$actionInfo = _$_ExchangeStoreActionController.startAction(
        name: '_ExchangeStore.reset');
    try {
      return super.reset();
    } finally {
      _$_ExchangeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExchangeRate(dynamic rate) {
    final _$actionInfo = _$_ExchangeStoreActionController.startAction(
        name: '_ExchangeStore.setExchangeRate');
    try {
      return super.setExchangeRate(rate);
    } finally {
      _$_ExchangeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTicker(dynamic newTicker) {
    final _$actionInfo = _$_ExchangeStoreActionController.startAction(
        name: '_ExchangeStore.setTicker');
    try {
      return super.setTicker(newTicker);
    } finally {
      _$_ExchangeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
exchangeRate: ${exchangeRate},
ticker: ${ticker},
isLoading: ${isLoading}
    ''';
  }
}
