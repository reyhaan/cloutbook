import 'package:cloutbook/repositories/HomeRepository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloutbook/models/PostModel.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, AsyncValue<List<Post>>>(
  (ref) => HomeController(ref.read),
);

class HomeController extends StateNotifier<AsyncValue<List<Post>>> {
  final Reader _read;

  HomeController(this._read) : super(AsyncValue.loading());

  Future<void> getGlobalFeed({Map<String, dynamic>? payload}) async {
    try {
      final feed = await _read(homeRepositoryProvider).getGlobalFeed(payload: {
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

      if (mounted) {
        state = AsyncValue.data(feed);
      }
    } catch (e) {}
  }
}
