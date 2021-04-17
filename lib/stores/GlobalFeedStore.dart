import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/repository/HomeRepository.dart';
import 'package:mobx/mobx.dart';

part 'GlobalFeedStore.g.dart';

class GlobalFeedStore extends _GlobalFeedStore with _$GlobalFeedStore {
  GlobalFeedStore(HomeRepository homeRepository) : super(homeRepository);
}

abstract class _GlobalFeedStore with Store {
  final HomeRepository _homeRepository;

  _GlobalFeedStore(this._homeRepository);

  @observable
  List<Post>? globalFeed;

  @action
  Future<void> getGlobalFeed() async {
    try {
      final response = await _homeRepository.getGlobalFeed(payload: {
        "PostHashHex": "",
        "ReaderPublicKeyBase58Check":
            "BC1YLgz2GMeUN28XtZQtXgYCT8Jhh9YSW2knS8r8L8EFuhdotVvLb17",
        "OrderBy": "newest",
        "StartTstampSecs": null,
        "PostContent": "",
        "NumToFetch": 50,
        "FetchSubcomments": false,
        "GetPostsForFollowFeed": true,
        "GetPostsForGlobalWhitelist": false,
        "GetPostsByClout": false,
        "PostsByCloutMinutesLookback": 0,
        "AddGlobalFeedBool": false
      });

      globalFeed = response;
    } catch (e) {}
  }
}
