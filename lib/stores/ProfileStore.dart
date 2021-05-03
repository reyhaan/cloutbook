import 'package:cloutbook/models/PostModel.dart';
import 'package:cloutbook/models/ProfileModel.dart';
import 'package:cloutbook/repository/ProfileRepository.dart';
import 'package:cloutbook/stores/ExchangeStore.dart';
import 'package:cloutbook/stores/GlobalFeedStore.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../models/ProfileModel.dart';

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
  String loggedInProfile = '';

  @observable
  Post postOpenedByUser = Post(timestampNanos: 0);

  @computed
  String get inCirculation {
    return (userProfile.coinEntry!.coinsInCirculationNanos! / 1000000000)
        .toStringAsFixed(4);
  }

  @computed
  String get coinPrice {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    if (_exchangeStore.ticker.usd != null &&
        userProfile.coinPriceBitCloutNanos != null &&
        _exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate != null) {
      double? bitcoinInUSD = _exchangeStore.ticker.usd?.current;
      double? bitCoinsPerBitClout =
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! /
                  100000000)
              .toDouble();
      double? bitCloutPrice = (bitcoinInUSD! * bitCoinsPerBitClout);
      return ((userProfile.coinPriceBitCloutNanos! / 1000000000) *
              bitCloutPrice)
          .toStringAsFixed(2);
    }
    return '0';
  }

  @computed
  String get totalUSDLocked {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    if (_exchangeStore.ticker.usd != null &&
        userProfile.coinEntry != null &&
        _exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate != null) {
      double? bitcoinInUSD = _exchangeStore.ticker.usd?.current;
      double? bitCoinsPerBitClout =
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! /
                  100000000)
              .toDouble();
      double? bitCloutPrice = (bitcoinInUSD! * bitCoinsPerBitClout);
      return ((userProfile.coinEntry!.bitCloutLockedNanos! / 1000000000) *
              bitCloutPrice)
          .toStringAsFixed(2);
    }
    return '0';
  }

  @computed
  String get bitCloutPrice {
    final ExchangeStore _exchangeStore = GetIt.I<ExchangeStore>();
    if (_exchangeStore.ticker.usd != null &&
        _exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate != null) {
      double? bitcoinInUSD = _exchangeStore.ticker.usd?.current;
      double? bitCoinsPerBitClout =
          (_exchangeStore.exchangeRate.satoshisPerBitCloutExchangeRate! /
                  100000000)
              .toDouble();
      return (bitcoinInUSD! * bitCoinsPerBitClout).toStringAsFixed(2);
    }
    return '0';
  }

  @computed
  String get totalUSDMarketCap {
    return (double.parse(coinPrice) * double.parse(inCirculation))
        .toStringAsFixed(2);
  }

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
    userProfile.followers = userFollowers;
  }

  @action
  void setUserProfile(profile) {
    userProfile = profile;
  }

  @action
  void setProfilePosts(posts) {
    ProfileEntryResponse oldProfile = userProfile;
    oldProfile.posts.addAll(posts);
    userProfile = oldProfile;
  }

  @action
  Future<void> getUserProfile({username}) async {
    try {
      isLoading = true;
      final profile = await _profileRepository.getUserProfile(payload: {
        "PublicKeyBase58Check": "",
        "Username": username,
      });

      final followers = await _profileRepository.getFollowers(payload: {
        "username": username,
        "PublicKeyBase58Check": "",
        "GetEntriesFollowingUsername": true,
        "LastPublicKeyBase58Check": "",
        "NumToFetch": 50
      });

      profile.setFollowers = followers.toString();
      setUserProfile(profile);
      setUserFollowers(followers);

      final posts = await _profileRepository.getPostsForPublicKey(payload: {
        "PublicKeyBase58Check": "",
        "Username": username,
        "ReaderPublicKeyBase58Check": profile.publicKeyBase58Check,
        "LastPostHashHex": "",
        "NumToFetch": 50
      }, profile: profile);

      setProfilePosts(posts);

      isLoading = false;
    } catch (e) {}
  }

  @action
  Future<ProfileEntryResponse> getPosterProfile({publicKey}) async {
    try {
      isLoading = true;
      final profile = await _profileRepository.getUserProfile(payload: {
        "PublicKeyBase58Check": publicKey,
        "Username": "",
      });
      isLoading = false;
      return profile;
    } catch (e) {
      throw e;
    }
  }

  Post? postFound;

  Post? getPostByHashHelper({required List<Post> posts, postHash}) {
    try {
      if (posts.length == 0) {
        return null;
      }
      for (var i = 0; i < posts.length; i++) {
        final post = posts[i];
        if (post.postHashHex == postHash) {
          postFound = post;
        }
        if (post.comments != null) {
          getPostByHashHelper(
            posts: post.comments!,
            postHash: postHash,
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }

  @action
  Post? getPostByHash({postHash, isProfile}) {
    final GlobalFeedStore _globalFeedStore = GetIt.I<GlobalFeedStore>();
    getPostByHashHelper(
      posts: isProfile ? userProfile.posts : _globalFeedStore.globalFeed,
      postHash: postHash,
    );
    return postFound;
  }

  Post? helper({
    required List<Post> posts,
    postHash,
    newPost,
  }) {
    if (posts.length == 0) {
      return null;
    }

    for (var i = 0; i < posts.length; i++) {
      final post = posts[i];
      if (post.postHashHex == postHash) {
        post.comments = newPost.comments;
      }
      if (post.comments != null) {
        helper(
          posts: post.comments!,
          postHash: postHash,
          newPost: newPost,
        );
      }
    }
  }

  @action
  void addRepliesByPostHash({postHash, newPost, isProfile}) {
    final GlobalFeedStore _globalFeedStore = GetIt.I<GlobalFeedStore>();
    helper(
      posts: isProfile ? userProfile.posts : _globalFeedStore.globalFeed,
      postHash: postHash,
      newPost: newPost,
    );

    // for rerender UI
    final oldGlobalStore = _globalFeedStore.globalFeed;
    _globalFeedStore.globalFeed = oldGlobalStore;

    final oldProfile = userProfile;
    userProfile = oldProfile;
  }

  @action
  Future<void> getSinglePost({postHash, isProfilePost}) async {
    try {
      isLoading = true;
      final post = await _profileRepository.getSinglePost(
        payload: {
          "PostHashHex": postHash,
          "ReaderPublicKeyBase58Check": userProfile.publicKeyBase58Check,
          "FetchParents": true,
          "CommentOffset": 0,
          "CommentLimit": 20,
          "AddGlobalFeedBool": false,
        },
      );
      isLoading = false;

      if (isProfilePost) {
        // update this particular post inside userprofile feed
        addRepliesByPostHash(
          postHash: postHash,
          newPost: post,
          isProfile: true,
        );
      } else {
        // update this particular feed item
        addRepliesByPostHash(
          postHash: postHash,
          newPost: post,
          isProfile: false,
        );
      }
    } catch (e) {
      throw e;
    }
  }

  @action
  Future<ProfileEntryResponse> getProfileByUsername({username}) async {
    try {
      isLoading = true;
      final profile = await _profileRepository.getUserProfile(payload: {
        "PublicKeyBase58Check": "",
        "Username": username,
      });
      isLoading = false;
      return profile;
    } catch (e) {
      throw e;
    }
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
}
