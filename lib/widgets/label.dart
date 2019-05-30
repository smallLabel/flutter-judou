import 'package:flutter/material.dart';
import '../utils/color_utils.dart';

class Label extends StatelessWidget {
  const Label({Key key, 
  this.title, 
  @required this.width,
  @required this.height,
  this.radius,
  this.onTap}) : super(key: key);

  final String title;
  final double width;
  final double height;
  final double radius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorUtils.textGreyColor),
            borderRadius: BorderRadius.all(Radius.circular(this.radius ?? 0)),
            shape: BoxShape.rectangle
          ),
          child: Center(
            child: Text(this.title, style: TextStyle(color: Colors.black45, fontSize: 12),),
          ),
        ),
      ),
      onTap: onTap ?? () => {},
    );
  }
}