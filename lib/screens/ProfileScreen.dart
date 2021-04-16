import 'package:cloutbook/widgets/Posts.dart';
import 'package:cloutbook/widgets/ProfileHeader.dart';
import 'package:cloutbook/widgets/ProfileMetadata.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ProfileHeader(),
          ProfileMetadata(),
          Posts(),
        ],
      ),
    );
  }
}
