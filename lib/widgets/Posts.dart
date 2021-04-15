import 'package:cloutbook/assets.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  Posts({Key key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PostItem(),
          PostItem(),
          PostItem(),
          PostItem(),
          PostItem(),
          PostItem(),
          PostItem(),
          PostItem(),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(bottom: 22, top: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Palette.foreground,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            margin: EdgeInsets.fromLTRB(16.0, 10.0, 20.0, 8.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage(Assets.avatar),
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'mohammadrehaan',
                    style: TextStyle(
                        color: Palette.primary4, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    'Skepticism for bitclout? Yeah right, just like bitcoin will never touch \$100 :)',
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.bubble_left,
                                size: 18.0,
                              ),
                            ),
                            TextSpan(text: '  12'),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.arrow_2_squarepath,
                                size: 18.0,
                              ),
                            ),
                            TextSpan(text: '  8'),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.heart,
                                size: 18.0,
                              ),
                            ),
                            TextSpan(text: '  25'),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.link,
                                size: 18.0,
                              ),
                            ),
                            TextSpan(text: '  1h'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
