import 'package:cloutbook/models/LoggedInUserModel.dart';
import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/repository/AuthRepository.dart';
import 'package:mobx/mobx.dart';

part 'AuthStore.g.dart';

class AuthStore extends _AuthStore with _$AuthStore {
  AuthStore(AuthRepository authRepository) : super(authRepository);
}

abstract class _AuthStore with Store {
  final AuthRepository _authRepository;

  _AuthStore(this._authRepository);

  @observable
  LoggedInUser loggedInUser = LoggedInUser.fromMap({});

  @observable
  bool isLoading = true;

  @action
  void reset() {
    loggedInUser = LoggedInUser.fromMap({});
    isLoading = false;
  }

  @action
  void setLoggedInUser(user) {
    loggedInUser = user;
  }

  @action
  LoggedInUser? getLoggedInUser() {
    LoggedInUser? loggedInUser = _authRepository.getLoggedInUser();
    return loggedInUser;
  }

  @action
  bool isUserAlreadyAdded(username) {
    return _authRepository.isUserAlreadyAdded(username: username);
  }

  @action
  LoggedInUser getUserByName(username) {
    return _authRepository.getUserByName(username: username);
  }

  @action
  LoggedInUser updateUser(LoggedInUser user) {
    return _authRepository.updateUser(payload: user);
  }

  @action
  List<LoggedInUser> getAllUsers() {
    return _authRepository.getUsers();
  }

  @action
  LoggedInUser addUser(LoggedInUser user) {
    final newUser = _authRepository.addUser(payload: user);
    loggedInUser = newUser;
    return newUser;
  }
}
