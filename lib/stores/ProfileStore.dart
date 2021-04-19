import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/repository/ProfileRepository.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'ProfileStore.g.dart';

class ProfileStore extends _ProfileStore with _$ProfileStore {
  ProfileStore(ProfileRepository profileRepository) : super(profileRepository);
}

abstract class _ProfileStore with Store {
  final ProfileRepository _profileRepository;

  _ProfileStore(this._profileRepository);

  @observable
  ProfileEntryResponse userProfile = ProfileEntryResponse(posts: []);

  @observable
  String userFollowers = '-';

  @computed
  String get inCirculation {
    return (userProfile.coinEntry!.coinsInCirculationNanos! / 1000000000)
        .toStringAsFixed(4);
  }

  @computed
  String get coinPrice {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    if (_exchangeStore.ticker.usd != null &&
        userProfile.coinPriceBitCloutNanos != null &&
        _exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate != null) {
      double? bitcoinInUSD = _exchangeStore.ticker.usd?.current;
      double? bitCoinsPerBitClout =
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! /
                  100000000)
              .toDouble();
      double? bitCloutPrice = (bitcoinInUSD! * bitCoinsPerBitClout);
      return ((userProfile.coinPriceBitCloutNanos! / 1000000000) *
              bitCloutPrice)
          .toStringAsFixed(2);
    }
    return '0';
  }

  @computed
  String get totalUSDLocked {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    if (_exchangeStore.ticker.usd != null &&
        userProfile.coinEntry != null &&
        _exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate != null) {
      double? bitcoinInUSD = _exchangeStore.ticker.usd?.current;
      double? bitCoinsPerBitClout =
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! /
                  100000000)
              .toDouble();
      double? bitCloutPrice = (bitcoinInUSD! * bitCoinsPerBitClout);
      return ((userProfile.coinEntry!.bitCloutLockedNanos! / 1000000000) *
              bitCloutPrice)
          .toStringAsFixed(2);
    }
    return '0';
  }

  @computed
  String get bitCloutPrice {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    if (_exchangeStore.ticker.usd != null &&
        _exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate != null) {
      double? bitcoinInUSD = _exchangeStore.ticker.usd?.current;
      double? bitCoinsPerBitClout =
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! /
                  100000000)
              .toDouble();
      return (bitcoinInUSD! * bitCoinsPerBitClout).toStringAsFixed(2);
    }
    return '0';
  }

  @computed
  String get totalUSDMarketCap {
    return (double.parse(coinPrice) * double.parse(inCirculation))
        .toStringAsFixed(2);
  }

  @observable
  bool isLoading = true;

  @action
  void reset() {
    isLoading = false;
  }

  @action
  void setUserFollowers(followers) {
    userFollowers = '';
    userFollowers = followers.toString();
  }

  @action
  void setUserProfile(profile) {
    userProfile = profile;
  }

  @action
  Future<void> getUserProfile() async {
    try {
      isLoading = true;
      final response = await _profileRepository.getUserProfile(payload: {
        "PublicKeyBase58Check": "",
        "Username": "CloutbookApp",
        "UsernamePrefix": "",
        "Description": "",
        "OrderBy": "newest_last_post",
        "NumToFetch": 1,
        "ReaderPublicKeyBase58Check":
            "BC1YLgz2GMeUN28XtZQtXgYCT8Jhh9YSW2knS8r8L8EFuhdotVvLb17",
        "ModerationType": "",
        "FetchUsersThatHODL": true,
        "AddGlobalFeedBool": false
      });
      isLoading = false;
      setUserProfile(response);

      final followers = await _profileRepository.getFollowers(payload: {
        "username": "cloutbookapp",
        "PublicKeyBase58Check": "",
        "GetEntriesFollowingUsername": true,
        "LastPublicKeyBase58Check": "",
        "NumToFetch": 50
      });

      setUserFollowers(followers);
    } catch (e) {}
  }

  @action
  Future<void> getFollowers() async {
    try {
      final response = await _profileRepository.getFollowers(payload: {
        "username": "mohammadrehaan",
        "PublicKeyBase58Check": "",
        "GetEntriesFollowingUsername": true,
        "LastPublicKeyBase58Check": "",
        "NumToFetch": 50
      });
      setUserFollowers(response.toString());
    } catch (e) {}
  }
}
