import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/models/WalletModel.dart';
import 'package:cloutbook/repository/ExploreRepository.dart';
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
  double balance = 0;

  @observable
  List<ProfileEntryResponse> savedProfiles = [];

  @action
  void reset() {
    isLoading = false;
    profiles = [];
    savedProfiles = [];
  }

  @action
  void setWallet(newWallet) {
    List<Wallet> oldWallet = wallet;
    oldWallet = newWallet;
    wallet = oldWallet;
    double total = 0;
    wallet.first.usersYouHODL!.forEach((user) {
      total = total + user.balanceNanos!;
    });
    balance = total;
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
    } catch (e) {}
  }
}
