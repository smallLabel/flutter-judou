import 'package:flutter/material.dart';
import '../utils/color_utils.dart';

class Blank extends StatelessWidget {
  const Blank({Key key, this.height = 10, this.color = ColorUtils.blankColor}) : super(key: key);

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(color: color),
      height: height,
      width: MediaQuery.of(context).size.width,
    );
  }
}