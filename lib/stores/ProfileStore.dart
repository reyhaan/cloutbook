import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/repository/ProfileRepository.dart';
import 'package:mobx/mobx.dart';

part 'ProfileStore.g.dart';

class ProfileStore extends _ProfileStore with _$ProfileStore {
  ProfileStore(ProfileRepository profileRepository) : super(profileRepository);
}

abstract class _ProfileStore with Store {
  final ProfileRepository _profileRepository;

  _ProfileStore(this._profileRepository);

  @observable
  ProfileEntryResponse userProfile = ProfileEntryResponse(posts: []);

  @observable
  String userFollowers = '-';

  @observable
  String coinPrice = '-';

  @observable
  String inCirculation = '-';

  @observable
  String totalUSDLoacked = '-';

  @observable
  String totalUSDMarketCap = '-';

  @observable
  bool isLoading = true;

  @action
  void reset() {
    isLoading = false;
  }

  @action
  void setUserFollowers(followers) {
    userFollowers = '';
    userFollowers = followers.toString();
  }

  @action
  void setUserProfile(profile) {
    userProfile = profile;
  }

  @action
  Future<void> getUserProfile() async {
    try {
      isLoading = true;
      final response = await _profileRepository.getUserProfile(payload: {
        "PublicKeyBase58Check": "",
        "Username": "CloutbookApp",
        "UsernamePrefix": "",
        "Description": "",
        "OrderBy": "newest_last_post",
        "NumToFetch": 1,
        "ReaderPublicKeyBase58Check":
            "BC1YLgz2GMeUN28XtZQtXgYCT8Jhh9YSW2knS8r8L8EFuhdotVvLb17",
        "ModerationType": "",
        "FetchUsersThatHODL": true,
        "AddGlobalFeedBool": false
      });
      isLoading = false;
      setUserProfile(response);

      final followers = await _profileRepository.getFollowers(payload: {
        "username": "cloutbookapp",
        "PublicKeyBase58Check": "",
        "GetEntriesFollowingUsername": true,
        "LastPublicKeyBase58Check": "",
        "NumToFetch": 50
      });

      setUserFollowers(followers);
    } catch (e) {}
  }

  @action
  Future<void> getFollowers() async {
    try {
      final response = await _profileRepository.getFollowers(payload: {
        "username": "mohammadrehaan",
        "PublicKeyBase58Check": "",
        "GetEntriesFollowingUsername": true,
        "LastPublicKeyBase58Check": "",
        "NumToFetch": 50
      });
      setUserFollowers(response.toString());
    } catch (e) {}
  }

  @action
  Future<void> getExchangeRate() async {
    try {
      final response = await _profileRepository.getExchangeRate();
    } catch (e) {}
  }
}
