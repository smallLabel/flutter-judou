import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_judou/utils/color_utils.dart';
import 'package:flutter_judou/widgets/judou_cell.dart';
import '../widgets/detail_label.dart';
import '../../widgets/blank.dart';
import '../models/judou_model.dart';
import '../models/comment_model.dart';
import '../BLoC/detail_bloc.dart';
import '../../bloc_provider.dart';
import '../widgets/comment_cell.dart';
import '../../widgets/loading.dart';
import '../widgets/end_cell.dart';
import '../../utils/ui_uitils.dart';



class DetailPage extends StatelessWidget {
  const DetailPage({Key key, this.model}) : super(key: key);

  final JuDouModel model;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: DetailBloc(uuid: model.uuid),
      child: DetailWidget(),
    );
  }
}

class DetailWidget extends StatefulWidget {
  DetailWidget({Key key, this.uuid}) : super(key: key);

  final String uuid;

  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {

  DetailBloc detailBloc;

  @override
  void initState() {
    
    super.initState();
    detailBloc = BlocProvider.of<DetailBloc>(context);
  }

  @override
  void dispose() {
    detailBloc.dispose();
    super.dispose();
  }

Widget sectionHeader(String title) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Text(title),
        ),
        Divider()
      ],
    ),
  );
}

  Widget hotComments(List<CommentModel> hotList) {
    List<CommentCell> listCell = List<CommentCell>();
    for (int i = 0; i < hotList.length; i++) {
      listCell.add(
        CommentCell(
          divider: i == hotList.length - 1 ? Container() : Divider(),
          model: hotList[i],
          )
      );
    }


    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          sectionHeader('热门评论'),
          Column(
            children: listCell,
          ),
          Blank()
        ],
      ),
    );
  }

  Widget body(BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.connectionState != ConnectionState.active) {
      return Center(
        child: Loading(),
      );
    }

    List<CommentModel> hot = snapshot.data['hot'];
    List<CommentModel> latest = snapshot.data['latest'];
    JuDouModel model = snapshot.data['detail'];

    int itemCount = latest.length + 5;
    String endString = latest.isEmpty ? '- END -' : '快来添加第一条评论';

    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 100,
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return JuDouCell(
                  divider: Blank(),
                  tag: 'index_detail',
                  model: model,
                  isCell: false,
                );
              } else if (index == 1) {
                return model.tags != null
                    ? DetailLabel(labelTitle: model.tags[0].name ?? '爱情')
                    : Container();
              } else if (index == 2) {
                  return hot.isEmpty ? hotComments(hot) : Container();
              } else if (index == 3) {
                  return latest.isEmpty ? sectionHeader('最新评论') : Container();
              } 
              if (index == itemCount - 1) {
                return EndCell(text: endString);
              }
              return CommentCell(
                divider: index == itemCount - 2 ? Container() : Divider(),
                model: latest[index - 4],
              );
              
            },
            itemCount: itemCount,
          ),
        )
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: detailBloc.commentStream,
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        return Scaffold(
          appBar: AppbarUtils.appBar('详情', context),
          backgroundColor: ColorUtils.blankColor,
          body: body(context, snapshot),
          floatingActionButton: _BottomInput(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          resizeToAvoidBottomPadding: true,
        );
      },
    );
  }
}

class _BottomInput extends StatelessWidget {
    const _BottomInput({Key key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return SafeArea(
        right: false,
        child: Container(
          height: 50,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Blank(height: 0.5, color: Colors.black12,),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                child: CupertinoTextField(
                  placeholder: '说点什么吧...',
                  textAlign: TextAlign.center,
                  decoration: BoxDecoration(
                    color: ColorUtils.dividerColor,
                    border: Border.all(color: Colors.transparent),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  style: TextStyle(
                    height: 1,
                    fontSize: 12,
                    color: ColorUtils.textGreyColor
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }