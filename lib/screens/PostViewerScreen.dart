import 'package:cloutbook/widgets/Replies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostViewerScreen extends HookWidget {
  const PostViewerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // fetch comments for this post
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Replies(),
      ),
    );
  }
}
