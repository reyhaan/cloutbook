import 'package:cloutbook/widgets/Posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfileScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Posts(
        isProfile: true,
      ),
    );
  }
}
