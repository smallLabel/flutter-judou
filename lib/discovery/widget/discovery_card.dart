import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_judou/widgets/radius_image.dart';
class DiscoveryCard extends StatelessWidget {
  const DiscoveryCard({
    Key key,
    this.isLeading,
    this.isTrailing,
    this.title,
    this.imageUrl,
    this.height,
    this.width,
    this.id
  }) : super(key: key);

  final bool isLeading;
  final bool isTrailing;
  final String title;
  final String imageUrl;
  final double height;
  final double width;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
        EdgeInsets.only(
          left: isLeading ? 15 : 4, 
          right: isTrailing ? 15 : 4
        ),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            SizedBox(
              child: Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.black26,
                      Colors.black12,
                      Colors.transparent
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3)
                  ),
                ),
                width: width,
                child: RadiusImage(
                  radius: 3,
                  width: width,
                  height: height,
                  imageUrl: imageUrl,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 84,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}