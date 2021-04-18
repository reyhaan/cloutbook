import 'package:cloutbook/models/ExchangeRateModel.dart';
import 'package:cloutbook/models/TickerModel.dart';
import 'package:cloutbook/repository/ExchangeRepository.dart';
import 'package:mobx/mobx.dart';

part 'ExchangeStore.g.dart';

class ExchangeStore extends _ExchangeStore with _$ExchangeStore {
  ExchangeStore(ExchangeRepository exchangeRepository)
      : super(exchangeRepository);
}

abstract class _ExchangeStore with Store {
  final ExchangeRepository _exchangeRepository;

  _ExchangeStore(this._exchangeRepository);

  @observable
  ExchangeRate exchangeRate = ExchangeRate();

  @observable
  Ticker ticker = Ticker();

  @observable
  bool isLoading = true;

  @action
  void reset() {
    isLoading = false;
  }

  @action
  void setExchangeRate(rate) {
    exchangeRate = rate;
  }

  @action
  void setTicker(newTicker) {
    ticker = newTicker;
  }

  @action
  Future<bool> disposeWebViews() async {
    await _exchangeRepository.dispose();
    return true;
  }

  @action
  Future<bool> getExchangeRate() async {
    try {
      await _exchangeRepository.getExchangeRate();
      return true;
    } catch (e) {
      throw e;
    }
  }

  @action
  Future<bool> getTicker() async {
    try {
      await _exchangeRepository.getTicker();
      return true;
    } catch (e) {
      throw e;
    }
  }
}
