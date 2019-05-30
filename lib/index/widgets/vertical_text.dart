import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VerticalText extends StatelessWidget {
  const VerticalText({Key key, this.text, this.color, this.size}) : super(key: key);
  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      child: Text(
        text,
        style: TextStyle(color: color, 
          fontSize: size,
          height: 0.85, 
          fontWeight: FontWeight.w300),
        ),
    );
  }
}