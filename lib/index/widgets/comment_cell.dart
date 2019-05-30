import 'package:flutter/material.dart';
import 'package:flutter_judou/utils/color_utils.dart';
import '../../widgets/radius_image.dart';
import '../models/comment_model.dart';

class CommentCell extends StatelessWidget {
  const CommentCell({Key key, @required this.model, @required this.divider}) : super(key: key);

  final CommentModel model;
  final Widget divider;

  Widget commentContent() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(model.content, 
                style: TextStyle(color: ColorUtils.textPrimaryColor,
                fontSize: 13, 
                height: 1.2),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _UserInfo(model: model,),
          Padding(
            padding: EdgeInsets.only(
              left: 35, 
              right: 15,
              bottom: model.replyToComment.isEmpty ? 0 : 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                commentContent(),
                model.replyToComment.isEmpty ? 
                  Container() : 
                  _ReplyContent(replyModel: CommentModel.fromJSON(model.replyToComment),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 35),
            child: divider,
          )
        ],
      ),
    );
  }
}

class _UpCount extends StatelessWidget {
  const _UpCount({Key key, this.isLiked, this.countStr}) : super(key: key);

  final bool isLiked;
  final String countStr;

  @override
  Widget build(BuildContext context) {
    Color color = isLiked ? Colors.black : ColorUtils.textGreyColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(countStr,
        style: TextStyle(fontSize: 10, color: color),
        textAlign: TextAlign.end),
        IconButton(
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.thumb_up),
          color: color,
          onPressed: null,
          iconSize: 12,
        )
      ],
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({Key key, this.model}) : super(key: key);
  final CommentModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RadiusImage(
                imageUrl: model.user.avatar,
                width: 30,
                height: 30,
                radius: 15,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      model.user.nickname,
                      style: TextStyle(fontSize: 13)
                    ),
                    Text(
                      'text',
                      style: TextStyle(fontSize: 10, color: ColorUtils.textGreyColor),
                      softWrap: true,
                      maxLines: 999,
                    )
                  ],
                  
                ),
              )
            ],
          ),
        ),
        _UpCount(isLiked: model.isLiked, countStr: model.upCount.toString(),)
      ],
    );
  }
}


class _ReplyContent extends StatelessWidget {
  const _ReplyContent({Key key, @required this.replyModel}) : super(key: key);

  final CommentModel replyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '${replyModel.user.nickname}: ',
              style: TextStyle(
                color: ColorUtils.textPrimaryColor, 
                fontSize: 12,
                height: 1.2
              )
            ),
            TextSpan(
              text: replyModel.content,
              style: TextStyle(height: 1.2, fontSize: 12, color: ColorUtils.textGreyColor)
            ),
          ]
          ),
      ),
      width: 999,
      padding: EdgeInsets.all(8),
      color: ColorUtils.blankColor,
    );
  }
}