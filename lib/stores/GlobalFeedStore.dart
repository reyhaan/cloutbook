import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/repository/HomeRepository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'GlobalFeedStore.g.dart';

class GlobalFeedStore extends _GlobalFeedStore with _$GlobalFeedStore {
  GlobalFeedStore(HomeRepository homeRepository) : super(homeRepository);
}

abstract class _GlobalFeedStore with Store {
  final HomeRepository _homeRepository;

  _GlobalFeedStore(this._homeRepository);

  @observable
  List<Post> globalFeed = [];

  @observable
  bool isLoading = true;

  @action
  void reset() {
    globalFeed = [];
    isLoading = false;
  }

  @action
  void setGlobalFeed(posts) {
    if (globalFeed.isNotEmpty) {
      if (globalFeed.isNotEmpty) {
        globalFeed.insertAll(globalFeed.length, posts);
      }
    } else {
      globalFeed = posts;
    }
  }

  @action
  Future<void> getGlobalFeed() async {
    try {
      isLoading = true;

      String? postHashHex;

      if (globalFeed.isNotEmpty) {
        if (globalFeed.isNotEmpty) {
          postHashHex = globalFeed.last.postHashHex;
        }
      }

      debugPrint('----------------- $postHashHex');

      final response = await _homeRepository.getGlobalFeed(payload: {
        "PostHashHex": postHashHex ?? "",
        "ReaderPublicKeyBase58Check":
            "BC1YLgz2GMeUN28XtZQtXgYCT8Jhh9YSW2knS8r8L8EFuhdotVvLb17",
        "OrderBy": "",
        "StartTstampSecs": 0,
        "PostContent": "",
        "NumToFetch": 50,
        "FetchSubcomments": false,
        "GetPostsForFollowFeed": false,
        "GetPostsForGlobalWhitelist": true,
        "GetPostsByClout": false,
        "PostsByCloutMinutesLookback": 0,
        "AddGlobalFeedBool": false
      });
      isLoading = false;
      setGlobalFeed(response);
    } catch (e) {}
  }
}
