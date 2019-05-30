import 'package:flutter/material.dart';
import '../BLoc/index_bloc.dart';
import '../models/judou_model.dart';
import '../../bloc_provider.dart';
import '../../utils/color_utils.dart';
import '../../widgets/button_subscript.dart';
import '../widgets/index_item.dart';

class IndexPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
		bloc: Indexbloc(),
		child: IndexWidget(),
		);
	}
}



class IndexWidget extends StatefulWidget {
	IndexWidget({Key key}) : super(key: key);

	_IndexWidgetState createState() => _IndexWidgetState();
}

class _IndexWidgetState extends State<IndexWidget>  
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

    PageController _pageController = PageController();
    Indexbloc _indexbloc;
    String _like = '';
    String _comment = '';
    String _isLike = '';


    @override
    void initState() {
      super.initState();
      _indexbloc = BlocProvider.of<Indexbloc>(context);
      _indexbloc.badgesStream.listen((List<String> data) {
        setState(() {
          _like = data[0];
          _comment = data[1];
          _isLike = data[2];
        });
      });
    }
  
    @override
    Widget build(BuildContext context) {
      return StreamBuilder(
        stream: _indexbloc.dailyStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Scaffold(
            appBar: indexAppBar(),
            body: buildBody(snapshot),
            backgroundColor: Colors.white,
          );
        },
      );
    }

    @override
    void dispose() {
      _pageController.dispose();
      _indexbloc.dispose();
      super.dispose();
    }

    @override
    bool get wantKeepAlive => true;

    Icon likeIcon() => _isLike == '0'
      ? Icon(
        Icons.favorite_border,
        color: ColorUtils.iconColor
      )
      : Icon(
        Icons.favorite,
        color: Colors.redAccent
      );
    
    Widget indexAppBar() => AppBar(
      iconTheme: IconThemeData(color: ColorUtils.iconColor),
      centerTitle: true,
      leading: Container(
        alignment: Alignment.center,
        child: Text(
          '句子',
          style: TextStyle(fontSize: 22.0, fontFamily: 'LiSung'),
          ),
      ),
      actions: <Widget>[
        SubscriptButton(
          icon: Icon(Icons.message),
          onPressed: () => _indexbloc.toDetailPage(context),
          subscript: _comment,
        ),
        SubscriptButton(
          icon: likeIcon(),
          subscript: _like,
        ),
        IconButton(
          icon: Icon(Icons.share, color: ColorUtils.iconColor,),
          onPressed: () => _indexbloc.toDetailPage(context),
        )
      ],
    );

    Widget buildBody(AsyncSnapshot<List<JuDouModel>> snapShot) {
		if (snapShot.connectionState != ConnectionState.active) {
			return Center(
				child: CircularProgressIndicator(),
			);
		}

		return PageView.builder(
			itemBuilder: (context, index) {
				return IndexPageItem(
          onTap: () => _indexbloc.toDetailPage(context),
          model: snapShot.data[index],
        );
			},
			itemCount: snapShot.data.length,
			controller: this._pageController,
			onPageChanged: _indexbloc.onPageChanged,
		);
    }
}
  
