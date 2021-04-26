// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  final _$loggedInUserAtom = Atom(name: '_AuthStore.loggedInUser');

  @override
  LoggedInUser get loggedInUser {
    _$loggedInUserAtom.reportRead();
    return super.loggedInUser;
  }

  @override
  set loggedInUser(LoggedInUser value) {
    _$loggedInUserAtom.reportWrite(value, super.loggedInUser, () {
      super.loggedInUser = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AuthStore.isLoading');

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

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void reset() {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.reset');
    try {
      return super.reset();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoggedInUser(dynamic user) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setLoggedInUser');
    try {
      return super.setLoggedInUser(user);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  LoggedInUser? getLoggedInUser() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.getLoggedInUser');
    try {
      return super.getLoggedInUser();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isUserAlreadyAdded(dynamic username) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.isUserAlreadyAdded');
    try {
      return super.isUserAlreadyAdded(username);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  LoggedInUser getUserByName(dynamic username) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.getUserByName');
    try {
      return super.getUserByName(username);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  LoggedInUser updateUser(LoggedInUser user) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.updateUser');
    try {
      return super.updateUser(user);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<LoggedInUser> getAllUsers() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.getAllUsers');
    try {
      return super.getAllUsers();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  LoggedInUser addUser(LoggedInUser user) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.addUser');
    try {
      return super.addUser(user);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loggedInUser: ${loggedInUser},
isLoading: ${isLoading}
    ''';
  }
}
