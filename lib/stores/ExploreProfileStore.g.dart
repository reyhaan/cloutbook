// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExploreProfileStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ExploreProfileStore on _ExploreProfileStore, Store {
  Computed<String>? _$inCirculationComputed;

  @override
  String get inCirculation =>
      (_$inCirculationComputed ??= Computed<String>(() => super.inCirculation,
              name: '_ExploreProfileStore.inCirculation'))
          .value;
  Computed<String>? _$coinPriceComputed;

  @override
  String get coinPrice =>
      (_$coinPriceComputed ??= Computed<String>(() => super.coinPrice,
              name: '_ExploreProfileStore.coinPrice'))
          .value;
  Computed<String>? _$totalUSDLockedComputed;

  @override
  String get totalUSDLocked =>
      (_$totalUSDLockedComputed ??= Computed<String>(() => super.totalUSDLocked,
              name: '_ExploreProfileStore.totalUSDLocked'))
          .value;
  Computed<String>? _$bitCloutPriceComputed;

  @override
  String get bitCloutPrice =>
      (_$bitCloutPriceComputed ??= Computed<String>(() => super.bitCloutPrice,
              name: '_ExploreProfileStore.bitCloutPrice'))
          .value;
  Computed<String>? _$totalUSDMarketCapComputed;

  @override
  String get totalUSDMarketCap => (_$totalUSDMarketCapComputed ??=
          Computed<String>(() => super.totalUSDMarketCap,
              name: '_ExploreProfileStore.totalUSDMarketCap'))
      .value;

  final _$userProfileAtom = Atom(name: '_ExploreProfileStore.userProfile');

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

  final _$userFollowersAtom = Atom(name: '_ExploreProfileStore.userFollowers');

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

  final _$loggedInProfileAtom =
      Atom(name: '_ExploreProfileStore.loggedInProfile');

  @override
  String get loggedInProfile {
    _$loggedInProfileAtom.reportRead();
    return super.loggedInProfile;
  }

  @override
  set loggedInProfile(String value) {
    _$loggedInProfileAtom.reportWrite(value, super.loggedInProfile, () {
      super.loggedInProfile = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ExploreProfileStore.isLoading');

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
      AsyncAction('_ExploreProfileStore.getUserProfile');

  @override
  Future<void> getUserProfile({dynamic username}) {
    return _$getUserProfileAsyncAction
        .run(() => super.getUserProfile(username: username));
  }

  final _$getPosterProfileAsyncAction =
      AsyncAction('_ExploreProfileStore.getPosterProfile');

  @override
  Future<ProfileEntryResponse> getPosterProfile({dynamic publicKey}) {
    return _$getPosterProfileAsyncAction
        .run(() => super.getPosterProfile(publicKey: publicKey));
  }

  final _$getProfileByUsernameAsyncAction =
      AsyncAction('_ExploreProfileStore.getProfileByUsername');

  @override
  Future<ProfileEntryResponse> getProfileByUsername({dynamic username}) {
    return _$getProfileByUsernameAsyncAction
        .run(() => super.getProfileByUsername(username: username));
  }

  final _$getFollowersAsyncAction =
      AsyncAction('_ExploreProfileStore.getFollowers');

  @override
  Future<void> getFollowers() {
    return _$getFollowersAsyncAction.run(() => super.getFollowers());
  }

  final _$_ExploreProfileStoreActionController =
      ActionController(name: '_ExploreProfileStore');

  @override
  void reset() {
    final _$actionInfo = _$_ExploreProfileStoreActionController.startAction(
        name: '_ExploreProfileStore.reset');
    try {
      return super.reset();
    } finally {
      _$_ExploreProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserFollowers(dynamic followers) {
    final _$actionInfo = _$_ExploreProfileStoreActionController.startAction(
        name: '_ExploreProfileStore.setUserFollowers');
    try {
      return super.setUserFollowers(followers);
    } finally {
      _$_ExploreProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserProfile(dynamic profile) {
    final _$actionInfo = _$_ExploreProfileStoreActionController.startAction(
        name: '_ExploreProfileStore.setUserProfile');
    try {
      return super.setUserProfile(profile);
    } finally {
      _$_ExploreProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProfilePosts(dynamic posts) {
    final _$actionInfo = _$_ExploreProfileStoreActionController.startAction(
        name: '_ExploreProfileStore.setProfilePosts');
    try {
      return super.setProfilePosts(posts);
    } finally {
      _$_ExploreProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userProfile: ${userProfile},
userFollowers: ${userFollowers},
loggedInProfile: ${loggedInProfile},
isLoading: ${isLoading},
inCirculation: ${inCirculation},
coinPrice: ${coinPrice},
totalUSDLocked: ${totalUSDLocked},
bitCloutPrice: ${bitCloutPrice},
totalUSDMarketCap: ${totalUSDMarketCap}
    ''';
  }
}
