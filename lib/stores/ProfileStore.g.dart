// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  Computed<String>? _$inCirculationComputed;

  @override
  String get inCirculation =>
      (_$inCirculationComputed ??= Computed<String>(() => super.inCirculation,
              name: '_ProfileStore.inCirculation'))
          .value;
  Computed<String>? _$coinPriceComputed;

  @override
  String get coinPrice =>
      (_$coinPriceComputed ??= Computed<String>(() => super.coinPrice,
              name: '_ProfileStore.coinPrice'))
          .value;
  Computed<String>? _$totalUSDLockedComputed;

  @override
  String get totalUSDLocked =>
      (_$totalUSDLockedComputed ??= Computed<String>(() => super.totalUSDLocked,
              name: '_ProfileStore.totalUSDLocked'))
          .value;
  Computed<String>? _$bitCloutPriceComputed;

  @override
  String get bitCloutPrice =>
      (_$bitCloutPriceComputed ??= Computed<String>(() => super.bitCloutPrice,
              name: '_ProfileStore.bitCloutPrice'))
          .value;
  Computed<String>? _$totalUSDMarketCapComputed;

  @override
  String get totalUSDMarketCap => (_$totalUSDMarketCapComputed ??=
          Computed<String>(() => super.totalUSDMarketCap,
              name: '_ProfileStore.totalUSDMarketCap'))
      .value;

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
  void setProfilePosts(dynamic posts) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.setProfilePosts');
    try {
      return super.setProfilePosts(posts);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userProfile: ${userProfile},
userFollowers: ${userFollowers},
isLoading: ${isLoading},
inCirculation: ${inCirculation},
coinPrice: ${coinPrice},
totalUSDLocked: ${totalUSDLocked},
bitCloutPrice: ${bitCloutPrice},
totalUSDMarketCap: ${totalUSDMarketCap}
    ''';
  }
}
