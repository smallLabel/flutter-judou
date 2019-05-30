import 'package:flutter/material.dart';

class RadiusImage extends StatelessWidget {
  const RadiusImage({Key key, 
  @required this.imageUrl,
  @required this.height,
  @required this.width,
  @required this.radius}) : super(key: key);

  final String imageUrl;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
      child: imageUrl == null || imageUrl == ''
              ? Image(image: AssetImage('assets/avatar_placeholder.png'),width: this.width, height: this.height,)
              : Image.network(this.imageUrl,
                  width: this.width, 
                  height: this.height, 
                  fit: BoxFit.cover, 
                  gaplessPlayback: true,),
    );
  }
}