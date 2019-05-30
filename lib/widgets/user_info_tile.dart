import 'package:flutter/material.dart';
import './radius_image.dart';
import '../utils/color_utils.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({Key key, this.avatar, this.name, this.trailName}) : super(key: key);

  final String avatar;
  final String name;
  final String trailName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RadiusImage(
          imageUrl: avatar,
          width: 20,
          height: 20,
          radius: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            name,
            style: TextStyle(fontSize: 10), 
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            trailName,
            style: TextStyle(fontSize: 10, color: ColorUtils.textGreyColor),
          ),
        )
      ],
    );
  }
}