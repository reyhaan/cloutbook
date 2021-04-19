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
  Future<void> getProfiles(dynamic searchKey) {
    return _$getProfilesAsyncAction.run(() => super.getProfiles(searchKey));
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
  String toString() {
    return '''
isLoading: ${isLoading},
profiles: ${profiles},
savedProfiles: ${savedProfiles}
    ''';
  }
}
