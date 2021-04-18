// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GlobalFeedStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GlobalFeedStore on _GlobalFeedStore, Store {
  final _$globalFeedAtom = Atom(name: '_GlobalFeedStore.globalFeed');

  @override
  List<Post> get globalFeed {
    _$globalFeedAtom.reportRead();
    return super.globalFeed;
  }

  @override
  set globalFeed(List<Post> value) {
    _$globalFeedAtom.reportWrite(value, super.globalFeed, () {
      super.globalFeed = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_GlobalFeedStore.isLoading');

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

  final _$getGlobalFeedAsyncAction =
      AsyncAction('_GlobalFeedStore.getGlobalFeed');

  @override
  Future<void> getGlobalFeed() {
    return _$getGlobalFeedAsyncAction.run(() => super.getGlobalFeed());
  }

  final _$_GlobalFeedStoreActionController =
      ActionController(name: '_GlobalFeedStore');

  @override
  void reset() {
    final _$actionInfo = _$_GlobalFeedStoreActionController.startAction(
        name: '_GlobalFeedStore.reset');
    try {
      return super.reset();
    } finally {
      _$_GlobalFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGlobalFeed(dynamic posts) {
    final _$actionInfo = _$_GlobalFeedStoreActionController.startAction(
        name: '_GlobalFeedStore.setGlobalFeed');
    try {
      return super.setGlobalFeed(posts);
    } finally {
      _$_GlobalFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
globalFeed: ${globalFeed},
isLoading: ${isLoading}
    ''';
  }
}
