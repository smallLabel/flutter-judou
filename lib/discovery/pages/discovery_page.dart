import 'package:flutter/material.dart';
import 'package:flutter_judou/discovery/widget/discovery_widget.dart';
import 'package:flutter_judou/discovery/widget/subscribe_widget.dart';
import 'package:flutter_judou/utils/color_utils.dart';

class DiscoveryPage extends StatefulWidget {
  DiscoveryPage({Key key}) : super(key: key);

  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> 
  with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _topTabController;
  List<Tab> tabs = [Tab(text: '订阅'), Tab(text: '发现'), Tab(text: '推荐'),];

  @override
  void initState() {
    super.initState();
    _topTabController = TabController(vsync: this, length: 3);
    _topTabController.index = 1;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _topTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(
          controller: _topTabController,
          tabs: tabs,
          indicatorColor: Colors.yellow,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: ColorUtils.textGreyColor,
          labelStyle: TextStyle(fontSize: 16),
          labelPadding: EdgeInsets.symmetric(horizontal: 4),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {},)
        ],
        
      ),
      body: TabBarView(
        controller: _topTabController,
        children: <Widget>[
          SubscribeWidget(),
          Discovery(),
          Text('text')
        ],
      ),
    );
  }
}

