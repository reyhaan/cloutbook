import 'package:cloutbook/models/HoldingModel.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/models/WalletModel.dart';
import 'package:cloutbook/repository/ExploreRepository.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/ProfileStore.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'ExploreStore.g.dart';

class ExploreStore extends _ExploreStore with _$ExploreStore {
  ExploreStore(ExploreRepository exploreRepository) : super(exploreRepository);
}

abstract class _ExploreStore with Store {
  final ExploreRepository _exploreRepository;

  _ExploreStore(this._exploreRepository);

  @observable
  bool isLoading = true;

  @observable
  List<ProfileEntryResponse> profiles = [];

  @observable
  List<Wallet> wallet = [];

  @observable
  List<Holding> holdings = [];

  @observable
  List<Holding> hodlers = [];

  @observable
  double marketValue = 0;

  @observable
  double marketCap = 0;

  @observable
  double balance = 0;

  @observable
  bool didSelectHoldings = true;

  @observable
  List<ProfileEntryResponse> savedProfiles = [];

  @action
  void reset() {
    isLoading = false;
    profiles = [];
    savedProfiles = [];
    marketValue = 0;
    marketCap = 0;
    hodlers = [];
    holdings = [];
    didSelectHoldings = true;
  }

  @action
  void setWallet(newWallet) {
    List<Wallet> oldWallet = wallet;
    oldWallet = newWallet;
    wallet = oldWallet;
    balance = double.parse(wallet.first.balanceNanos.toString());
  }

  @action
  void getHoldings() {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    Map<String, dynamic> _holding = {};
    List<Holding> tempHoldings = [];

    wallet.first.usersYouHODL?.forEach((user) {
      // set amount of coins
      _holding['Amount'] = user.balanceNanos! / 1000000000;
      _holding['Price'] = double.parse(_exchangeStore.getCoinPrice(user.profileEntryResponse?.coinPriceBitCloutNanos));
      _holding['MarketValue'] = _holding['Price'] * _holding['Amount'];
      _holding['Username'] = user.profileEntryResponse?.username;
      _holding['PublicKey'] = user.profileEntryResponse?.publicKeyBase58Check;
      _holding['ProfilePic'] = user.profileEntryResponse?.profilePic;
      tempHoldings.add(Holding.fromMap(_holding));
    });

    tempHoldings.forEach((holding) {
      marketValue = marketValue + holding.marketValue;
    });

    for (var i = 0; i < tempHoldings.length; i++) {
      if (tempHoldings[i].marketValue == 0) {
        tempHoldings[i].percentShare = 0;
      } else {
        tempHoldings[i].percentShare = (tempHoldings[i].marketValue / marketValue) * 100;
      }
    }

    tempHoldings.sort((a, b) => b.percentShare.compareTo(a.percentShare));

    holdings = tempHoldings;
  }

  @action
  void getHodlers() {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    final ProfileStore _profileStore = GetIt.I<ProfileStore>();
    Map<String, dynamic> _holding = {};
    List<Holding> tempHoldings = [];

    wallet.first.usersWhoHODLYou?.forEach((user) {
      // set amount of coins
      _holding['Amount'] = user.balanceNanos! / 1000000000;
      _holding['Price'] = double.parse(_exchangeStore.getCoinPrice(_profileStore.userProfile.coinPriceBitCloutNanos));
      _holding['MarketValue'] = _holding['Price'] * _holding['Amount'];
      _holding['Username'] = user.profileEntryResponse?.username ?? user.hodlerPublicKeyBase58Check;
      _holding['PublicKey'] = user.profileEntryResponse?.publicKeyBase58Check;
      _holding['ProfilePic'] = user.profileEntryResponse?.profilePic ?? '';
      tempHoldings.add(Holding.fromMap(_holding));
    });

    tempHoldings.forEach((holding) {
      marketCap = marketCap + holding.marketValue;
    });

    for (var i = 0; i < tempHoldings.length; i++) {
      if (tempHoldings[i].marketValue == 0) {
        tempHoldings[i].percentShare = 0;
      } else {
        tempHoldings[i].percentShare = (tempHoldings[i].marketValue / marketCap) * 100;
      }
    }

    tempHoldings.sort((a, b) => b.percentShare.compareTo(a.percentShare));

    hodlers = tempHoldings;
  }

  @action
  void setProfiles(newProfiles) {
    profiles = newProfiles;
  }

  @action
  void setSavedProfiles(newProfiles) {
    savedProfiles = newProfiles;
  }

  @action
  void updateSavedProfiles(newProfiles) {
    List<ProfileEntryResponse> oldProfiles = savedProfiles;
    oldProfiles.addAll(newProfiles);
    savedProfiles = oldProfiles;
  }

  @action
  void removeSavedProfiles(ProfileEntryResponse profile) {
    List<ProfileEntryResponse> oldProfiles = savedProfiles;
    oldProfiles.removeWhere((element) => element.username == profile.username);
    savedProfiles = oldProfiles;
  }

  @action
  Future<void> getProfiles(searchKey, publicKey) async {
    try {
      isLoading = true;
      final response = await _exploreRepository.getProfiles(payload: {
        "PublicKeyBase58Check": "",
        "Username": "",
        "UsernamePrefix": searchKey ?? "",
        "Description": "",
        "OrderBy": "",
        "NumToFetch": 10,
        "ReaderPublicKeyBase58Check": publicKey,
        "ModerationType": "",
        "FetchUsersThatHODL": true,
        "AddGlobalFeedBool": false
      });
      isLoading = false;
      setProfiles(response);
    } catch (e) {
      throw e;
    }
  }

  @action
  Future<void> getWatchlist() async {
    try {
      isLoading = true;
      final response = await _exploreRepository.getWatchlist();
      isLoading = false;

      if (response.length > 0) {
        setSavedProfiles(response);
      }
    } catch (e) {
      throw e;
    }
  }

  @action
  Future<void> addToWatchlist(ProfileEntryResponse profile) async {
    try {
      isLoading = true;
      await _exploreRepository.addToWatchlist(payload: profile);
      isLoading = false;
      updateSavedProfiles([profile]);
    } catch (e) {
      throw e;
    }
  }

  @action
  Future<void> removeFromWatchlist(profile) async {
    try {
      isLoading = true;
      await _exploreRepository.removeFromWatchlist(payload: profile);
      isLoading = false;
      removeSavedProfiles(profile);
    } catch (e) {
      throw e;
    }
  }

  @action
  bool isInWatchlist(profile) {
    try {
      isLoading = true;
      final response = _exploreRepository.isInWatchlist(payload: profile);
      isLoading = false;
      return response;
    } catch (e) {
      throw e;
    }
  }

  @action
  Future<void> getWallet(publicKey) async {
    try {
      final userList = {
        "PublicKeysBase58Check": [publicKey]
      };
      final wallet = await _exploreRepository.getWallet(payload: userList);
      setWallet(wallet);
      getHoldings();
      getHodlers();
    } catch (e) {}
  }
}
