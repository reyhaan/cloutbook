// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  final _$userProfileAtom = Atom(name: '_ProfileStore.userProfile');

  @override
  ProfileEntryResponse get userProfile {
    _$userProfileAtom.reportRead();
    return super.userProfile;
  }

  @override
  set userProfile(ProfileEntryResponse value) {
    _$userProfileAtom.reportWrite(value, super.userProfile, () {
      super.userProfile = value;
    });
  }

  final _$userFollowersAtom = Atom(name: '_ProfileStore.userFollowers');

  @override
  String get userFollowers {
    _$userFollowersAtom.reportRead();
    return super.userFollowers;
  }

  @override
  set userFollowers(String value) {
    _$userFollowersAtom.reportWrite(value, super.userFollowers, () {
      super.userFollowers = value;
    });
  }

  final _$coinPriceAtom = Atom(name: '_ProfileStore.coinPrice');

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

  final _$inCirculationAtom = Atom(name: '_ProfileStore.inCirculation');

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

  final _$totalUSDLockedAtom = Atom(name: '_ProfileStore.totalUSDLocked');

  @override
  String get totalUSDLocked {
    _$totalUSDLockedAtom.reportRead();
    return super.totalUSDLocked;
  }

  @override
  set totalUSDLocked(String value) {
    _$totalUSDLockedAtom.reportWrite(value, super.totalUSDLocked, () {
      super.totalUSDLocked = value;
    });
  }

  final _$totalUSDMarketCapAtom = Atom(name: '_ProfileStore.totalUSDMarketCap');

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

  final _$isLoadingAtom = Atom(name: '_ProfileStore.isLoading');

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

  final _$getUserProfileAsyncAction =
      AsyncAction('_ProfileStore.getUserProfile');

  @override
  Future<void> getUserProfile() {
    return _$getUserProfileAsyncAction.run(() => super.getUserProfile());
  }

  final _$getFollowersAsyncAction = AsyncAction('_ProfileStore.getFollowers');

  @override
  Future<void> getFollowers() {
    return _$getFollowersAsyncAction.run(() => super.getFollowers());
  }

  final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore');

  @override
  void reset() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.reset');
    try {
      return super.reset();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserFollowers(dynamic followers) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.setUserFollowers');
    try {
      return super.setUserFollowers(followers);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserProfile(dynamic profile) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.setUserProfile');
    try {
      return super.setUserProfile(profile);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userProfile: ${userProfile},
userFollowers: ${userFollowers},
coinPrice: ${coinPrice},
inCirculation: ${inCirculation},
totalUSDLocked: ${totalUSDLocked},
totalUSDMarketCap: ${totalUSDMarketCap},
isLoading: ${isLoading}
    ''';
  }
}
