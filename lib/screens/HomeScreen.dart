import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/widgets/Posts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// https://api.bitclout.com/get-posts-stateless
// https://api.bitclout.com/get-exchange-rate
// https://api.bitclout.com/get-app-state

void getHttp() async {
  try {
    var dio = Dio();
    dio.options.baseUrl = 'https://api.bitclout.com';
    dio.options.headers = {'Content-Type': 'application/json'};

    var response = await dio.post('/get-app-state', data: {});

    response = await dio.post('/get-posts-stateless', data: {
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
    print(response);
  } catch (e) {
    print(e);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // getHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            createHomeSilverAppBar(),
          ];
        },
        body: Posts(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          getHttp();
        },
      ),
    );
  }
}

SliverAppBar createHomeSilverAppBar() {
  return SliverAppBar(
    backgroundColor: Colors.transparent,
    expandedHeight: 65,
    floating: false,
    elevation: 0,
    flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          color: Palette.background,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Global',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }),
  );
}
