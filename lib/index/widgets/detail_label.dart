import 'package:flutter/material.dart';
import '../../widgets/blank.dart';
import '../../widgets/label.dart';

class DetailLabel extends StatelessWidget {
  const DetailLabel({Key key, this.labelTitle}) : super(key: key);
  final String labelTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Label(
                  title: labelTitle,
                  height: 20,
                  width: 40,
                  radius: 10,
                  onTap: () => print('爱情'),
                ),
              ),
            ],
          ),
          Blank()
        ],
      ),
    );
  }
}