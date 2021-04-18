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
  Map<String, dynamic> exchangeRate = {};

  @observable
  Map<String, dynamic> ticker = {};

  @observable
  String coinPrice = '-';

  @observable
  String inCirculation = '-';

  @observable
  String totalUSDLoacked = '-';

  @observable
  String totalUSDMarketCap = '-';

  @observable
  bool isLoading = true;

  @action
  void reset() {
    isLoading = false;
  }

  @action
  Future<void> getExchangeRate() async {
    try {
      final response = await _exchangeRepository.getExchangeRate();
      exchangeRate = response;
    } catch (e) {}
  }

  @action
  Future<void> getTicker() async {
    try {
      final response = await _exchangeRepository.getTicker();
      ticker = response;
    } catch (e) {}
  }
}
