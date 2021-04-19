import 'package:cloutbook/models/ProfileModel.dart';
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
  List<ProfileEntryResponse> savedProfiles = [];

  @action
  void reset() {
    isLoading = false;
    profiles = [];
  }

  @action
  void setProfiles(newProfiles) {
    profiles = newProfiles;
  }

  @action
  Future<void> getProfiles(searchKey) async {
    try {
      isLoading = true;
      final response = await _exploreRepository.getProfiles(payload: {
        "PublicKeyBase58Check": "",
        "Username": "",
        "UsernamePrefix": searchKey ?? "",
        "Description": "",
        "OrderBy": "",
        "NumToFetch": 20,
        "ReaderPublicKeyBase58Check":
            "BC1YLgz2GMeUN28XtZQtXgYCT8Jhh9YSW2knS8r8L8EFuhdotVvLb17",
        "ModerationType": "",
        "FetchUsersThatHODL": false,
        "AddGlobalFeedBool": false
      });
      isLoading = false;
      print(response.length);
      setProfiles(response);
    } catch (e) {
      throw e;
    }
  }
}
