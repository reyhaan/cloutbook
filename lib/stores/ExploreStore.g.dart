// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExploreStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ExploreStore on _ExploreStore, Store {
  final _$isLoadingAtom = Atom(name: '_ExploreStore.isLoading');

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

  final _$profilesAtom = Atom(name: '_ExploreStore.profiles');

  @override
  List<ProfileEntryResponse> get profiles {
    _$profilesAtom.reportRead();
    return super.profiles;
  }

  @override
  set profiles(List<ProfileEntryResponse> value) {
    _$profilesAtom.reportWrite(value, super.profiles, () {
      super.profiles = value;
    });
  }

  final _$walletAtom = Atom(name: '_ExploreStore.wallet');

  @override
  List<Wallet> get wallet {
    _$walletAtom.reportRead();
    return super.wallet;
  }

  @override
  set wallet(List<Wallet> value) {
    _$walletAtom.reportWrite(value, super.wallet, () {
      super.wallet = value;
    });
  }

  final _$holdingsAtom = Atom(name: '_ExploreStore.holdings');

  @override
  List<Holding> get holdings {
    _$holdingsAtom.reportRead();
    return super.holdings;
  }

  @override
  set holdings(List<Holding> value) {
    _$holdingsAtom.reportWrite(value, super.holdings, () {
      super.holdings = value;
    });
  }

  final _$hodlersAtom = Atom(name: '_ExploreStore.hodlers');

  @override
  List<Holding> get hodlers {
    _$hodlersAtom.reportRead();
    return super.hodlers;
  }

  @override
  set hodlers(List<Holding> value) {
    _$hodlersAtom.reportWrite(value, super.hodlers, () {
      super.hodlers = value;
    });
  }

  final _$marketValueAtom = Atom(name: '_ExploreStore.marketValue');

  @override
  double get marketValue {
    _$marketValueAtom.reportRead();
    return super.marketValue;
  }

  @override
  set marketValue(double value) {
    _$marketValueAtom.reportWrite(value, super.marketValue, () {
      super.marketValue = value;
    });
  }

  final _$marketCapAtom = Atom(name: '_ExploreStore.marketCap');

  @override
  double get marketCap {
    _$marketCapAtom.reportRead();
    return super.marketCap;
  }

  @override
  set marketCap(double value) {
    _$marketCapAtom.reportWrite(value, super.marketCap, () {
      super.marketCap = value;
    });
  }

  final _$balanceAtom = Atom(name: '_ExploreStore.balance');

  @override
  double get balance {
    _$balanceAtom.reportRead();
    return super.balance;
  }

  @override
  set balance(double value) {
    _$balanceAtom.reportWrite(value, super.balance, () {
      super.balance = value;
    });
  }

  final _$didSelectHoldingsAtom = Atom(name: '_ExploreStore.didSelectHoldings');

  @override
  bool get didSelectHoldings {
    _$didSelectHoldingsAtom.reportRead();
    return super.didSelectHoldings;
  }

  @override
  set didSelectHoldings(bool value) {
    _$didSelectHoldingsAtom.reportWrite(value, super.didSelectHoldings, () {
      super.didSelectHoldings = value;
    });
  }

  final _$savedProfilesAtom = Atom(name: '_ExploreStore.savedProfiles');

  @override
  List<ProfileEntryResponse> get savedProfiles {
    _$savedProfilesAtom.reportRead();
    return super.savedProfiles;
  }

  @override
  set savedProfiles(List<ProfileEntryResponse> value) {
    _$savedProfilesAtom.reportWrite(value, super.savedProfiles, () {
      super.savedProfiles = value;
    });
  }

  final _$getProfilesAsyncAction = AsyncAction('_ExploreStore.getProfiles');

  @override
  Future<void> getProfiles(dynamic searchKey, dynamic publicKey) {
    return _$getProfilesAsyncAction
        .run(() => super.getProfiles(searchKey, publicKey));
  }

  final _$getWatchlistAsyncAction = AsyncAction('_ExploreStore.getWatchlist');

  @override
  Future<void> getWatchlist() {
    return _$getWatchlistAsyncAction.run(() => super.getWatchlist());
  }

  final _$addToWatchlistAsyncAction =
      AsyncAction('_ExploreStore.addToWatchlist');

  @override
  Future<void> addToWatchlist(ProfileEntryResponse profile) {
    return _$addToWatchlistAsyncAction.run(() => super.addToWatchlist(profile));
  }

  final _$removeFromWatchlistAsyncAction =
      AsyncAction('_ExploreStore.removeFromWatchlist');

  @override
  Future<void> removeFromWatchlist(dynamic profile) {
    return _$removeFromWatchlistAsyncAction
        .run(() => super.removeFromWatchlist(profile));
  }

  final _$getWalletAsyncAction = AsyncAction('_ExploreStore.getWallet');

  @override
  Future<void> getWallet(dynamic publicKey) {
    return _$getWalletAsyncAction.run(() => super.getWallet(publicKey));
  }

  final _$_ExploreStoreActionController =
      ActionController(name: '_ExploreStore');

  @override
  void reset() {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.reset');
    try {
      return super.reset();
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWallet(dynamic newWallet) {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.setWallet');
    try {
      return super.setWallet(newWallet);
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getHoldings() {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.getHoldings');
    try {
      return super.getHoldings();
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getHodlers() {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.getHodlers');
    try {
      return super.getHodlers();
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProfiles(dynamic newProfiles) {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.setProfiles');
    try {
      return super.setProfiles(newProfiles);
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSavedProfiles(dynamic newProfiles) {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.setSavedProfiles');
    try {
      return super.setSavedProfiles(newProfiles);
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSavedProfiles(dynamic newProfiles) {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.updateSavedProfiles');
    try {
      return super.updateSavedProfiles(newProfiles);
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSavedProfiles(ProfileEntryResponse profile) {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.removeSavedProfiles');
    try {
      return super.removeSavedProfiles(profile);
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isInWatchlist(dynamic profile) {
    final _$actionInfo = _$_ExploreStoreActionController.startAction(
        name: '_ExploreStore.isInWatchlist');
    try {
      return super.isInWatchlist(profile);
    } finally {
      _$_ExploreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
profiles: ${profiles},
wallet: ${wallet},
holdings: ${holdings},
hodlers: ${hodlers},
marketValue: ${marketValue},
marketCap: ${marketCap},
balance: ${balance},
didSelectHoldings: ${didSelectHoldings},
savedProfiles: ${savedProfiles}
    ''';
  }
}
