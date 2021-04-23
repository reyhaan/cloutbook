import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../config/palette.dart';

class ImageViewerScreen extends StatelessWidget {
  final imageUrl;

  const ImageViewerScreen({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: PhotoView(
                  filterQuality: FilterQuality.high,
                  imageProvider: NetworkImage(imageUrl),
                ),
              ),
              Positioned(
                top: 18,
                right: 18,
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Palette.foreground.withAlpha(180),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
