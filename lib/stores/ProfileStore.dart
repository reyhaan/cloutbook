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

  @observable
  String loggedInProfile = '';

  @computed
  String get inCirculation {
    return (userProfile.coinEntry!.coinsInCirculationNanos! / 1000000000).toStringAsFixed(4);
  }

  @computed
  String get coinPrice {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    if (_exchangeStore.ticker.usd != null &&
        userProfile.coinPriceBitCloutNanos != null &&
        _exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate != null) {
      double? bitcoinInUSD = _exchangeStore.ticker.usd?.current;
      double? bitCoinsPerBitClout =
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! / 100000000).toDouble();
      double? bitCloutPrice = (bitcoinInUSD! * bitCoinsPerBitClout);
      return ((userProfile.coinPriceBitCloutNanos! / 1000000000) * bitCloutPrice).toStringAsFixed(2);
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
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! / 100000000).toDouble();
      double? bitCloutPrice = (bitcoinInUSD! * bitCoinsPerBitClout);
      return ((userProfile.coinEntry!.bitCloutLockedNanos! / 1000000000) * bitCloutPrice).toStringAsFixed(2);
    }
    return '0';
  }

  @computed
  String get bitCloutPrice {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    if (_exchangeStore.ticker.usd != null && _exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate != null) {
      double? bitcoinInUSD = _exchangeStore.ticker.usd?.current;
      double? bitCoinsPerBitClout =
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! / 100000000).toDouble();
      return (bitcoinInUSD! * bitCoinsPerBitClout).toStringAsFixed(2);
    }
    return '0';
  }

  @computed
  String get totalUSDMarketCap {
    return (double.parse(coinPrice) * double.parse(inCirculation)).toStringAsFixed(2);
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
  void setProfilePosts(posts) {
    ProfileEntryResponse oldProfile = userProfile;
    oldProfile.posts.addAll(posts);
    userProfile = oldProfile;
  }

  @action
  Future<void> getUserProfile({username}) async {
    try {
      isLoading = true;
      final profile = await _profileRepository.getUserProfile(payload: {
        "PublicKeyBase58Check": "",
        "Username": username,
      });
      setUserProfile(profile);

      final followers = await _profileRepository.getFollowers(payload: {
        "username": username,
        "PublicKeyBase58Check": "",
        "GetEntriesFollowingUsername": true,
        "LastPublicKeyBase58Check": "",
        "NumToFetch": 50
      });

      setUserFollowers(followers);

      final posts = await _profileRepository.getPostsForPublicKey(payload: {
        "PublicKeyBase58Check": "",
        "Username": username,
        "ReaderPublicKeyBase58Check": profile.publicKeyBase58Check,
        "LastPostHashHex": "",
        "NumToFetch": 50
      }, profile: profile);

      setProfilePosts(posts);

      isLoading = false;
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
