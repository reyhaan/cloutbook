// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExchangeStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ExchangeStore on _ExchangeStore, Store {
  final _$exchangeRateAtom = Atom(name: '_ExchangeStore.exchangeRate');

  @override
  Map<String, dynamic> get exchangeRate {
    _$exchangeRateAtom.reportRead();
    return super.exchangeRate;
  }

  @override
  set exchangeRate(Map<String, dynamic> value) {
    _$exchangeRateAtom.reportWrite(value, super.exchangeRate, () {
      super.exchangeRate = value;
    });
  }

  final _$tickerAtom = Atom(name: '_ExchangeStore.ticker');

  @override
  Map<String, dynamic> get ticker {
    _$tickerAtom.reportRead();
    return super.ticker;
  }

  @override
  set ticker(Map<String, dynamic> value) {
    _$tickerAtom.reportWrite(value, super.ticker, () {
      super.ticker = value;
    });
  }

  final _$coinPriceAtom = Atom(name: '_ExchangeStore.coinPrice');

  @override
  String get coinPrice {
    _$coinPriceAtom.reportRead();
    return super.coinPrice;
  }

  @override
  set coinPrice(String value) {
    _$coinPriceAtom.reportWrite(value, super.coinPrice, () {
      super.coinPrice = value;
    });
  }

  final _$inCirculationAtom = Atom(name: '_ExchangeStore.inCirculation');

  @override
  String get inCirculation {
    _$inCirculationAtom.reportRead();
    return super.inCirculation;
  }

  @override
  set inCirculation(String value) {
    _$inCirculationAtom.reportWrite(value, super.inCirculation, () {
      super.inCirculation = value;
    });
  }

  final _$totalUSDLoackedAtom = Atom(name: '_ExchangeStore.totalUSDLoacked');

  @override
  String get totalUSDLoacked {
    _$totalUSDLoackedAtom.reportRead();
    return super.totalUSDLoacked;
  }

  @override
  set totalUSDLoacked(String value) {
    _$totalUSDLoackedAtom.reportWrite(value, super.totalUSDLoacked, () {
      super.totalUSDLoacked = value;
    });
  }

  final _$totalUSDMarketCapAtom =
      Atom(name: '_ExchangeStore.totalUSDMarketCap');

  @override
  String get totalUSDMarketCap {
    _$totalUSDMarketCapAtom.reportRead();
    return super.totalUSDMarketCap;
  }

  @override
  set totalUSDMarketCap(String value) {
    _$totalUSDMarketCapAtom.reportWrite(value, super.totalUSDMarketCap, () {
      super.totalUSDMarketCap = value;
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

  final _$getExchangeRateAsyncAction =
      AsyncAction('_ExchangeStore.getExchangeRate');

  @override
  Future<void> getExchangeRate() {
    return _$getExchangeRateAsyncAction.run(() => super.getExchangeRate());
  }

  final _$getTickerAsyncAction = AsyncAction('_ExchangeStore.getTicker');

  @override
  Future<void> getTicker() {
    return _$getTickerAsyncAction.run(() => super.getTicker());
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
  String toString() {
    return '''
exchangeRate: ${exchangeRate},
ticker: ${ticker},
coinPrice: ${coinPrice},
inCirculation: ${inCirculation},
totalUSDLoacked: ${totalUSDLoacked},
totalUSDMarketCap: ${totalUSDMarketCap},
isLoading: ${isLoading}
    ''';
  }
}
