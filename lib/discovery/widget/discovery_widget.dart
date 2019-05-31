import 'package:flutter_judou/bloc_provider.dart';
import 'package:flutter_judou/discovery/bloc/discovery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_judou/discovery/models/topic_model.dart';
import 'package:flutter_judou/discovery/widget/discovery_card.dart';
import 'package:flutter_judou/index/models/judou_model.dart';
import 'package:flutter_judou/index/models/tag_model.dart';
import 'package:flutter_judou/widgets/blank.dart';
import 'package:flutter_judou/widgets/judou_cell.dart';
import 'package:flutter_judou/widgets/loading.dart';

class Discovery extends StatelessWidget {
  const Discovery({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: DiscoveryBloc(),
      child: DiscoveryWidget(),
    );
  }
}

class DiscoveryWidget extends StatefulWidget {
  DiscoveryWidget({Key key}) : super(key: key);

  _DiscoveryWidgetState createState() => _DiscoveryWidgetState();
}

class _DiscoveryWidgetState extends State<DiscoveryWidget> 
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  
  ScrollController _scrollController;
  TabController _tabController;
  DiscoveryBloc _bloc;
  @override
  void initState() {
    
    super.initState();
    _bloc = BlocProvider.of<DiscoveryBloc>(context);
    _scrollController = ScrollController();
    _tabController = TabController();
    _scrollController.addListener(() => {});
  }

  List<Tab> _tagWidgets(List<TagModel> tags) {
    return tags.map((item) => Tab(
      text: item.name,
    )).toList();
  }

  List<Widget> _tabBarViews(List<TagModel> tags, List<JuDouModel> models) {
    return _tagWidgets(tags).map(
      (item) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return JuDouCell(
              model: models[index],
              divider: Blank(height: 10,),
              tag: 'discovery$index',
              isCell: true,
            );
          },
          itemCount: tags.length,
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
        );
      }
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(
            child: Loading(),
          );
        }
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              // TODO
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
    
}

class _DiscoveryTopicsWidget extends StatelessWidget {
  const _DiscoveryTopicsWidget({Key key, this.topics}) : super(key: key);

  final List<TopicModel> topics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      height: 100,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topics.length,
        itemBuilder: (context, index) {
          TopicModel model = topics[index];
          return DiscoveryCard(
            title: model.name,
            isLeading: index == 0 ? true : false,
            isTrailing: index == topics.length - 1 ? true : false,
            imageUrl: model.cover,
            height: 70,
            width: 100,
            id: model.uuid,
          );
        },
      ),
    );
  }
}