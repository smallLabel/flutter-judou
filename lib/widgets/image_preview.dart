import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key key, this.imageUrl, this.tag}) : super(key: key);

  final String imageUrl;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: tag,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.network(this.imageUrl),
          ),
          transitionOnUserGestures: true,
        ),
      ),
    );
  }
}