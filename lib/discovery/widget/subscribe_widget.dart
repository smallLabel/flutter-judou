import 'package:flutter/material.dart';
import 'package:flutter_judou/discovery/bloc/subscribe_bloc.dart';
import 'package:flutter_judou/index/models/judou_model.dart';
import 'package:flutter_judou/widgets/blank.dart';
import 'package:flutter_judou/widgets/judou_cell.dart';
import 'package:flutter_judou/widgets/loading.dart';
import '../../bloc_provider.dart';



class DiscoverySubscribe extends StatelessWidget {
  const DiscoverySubscribe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: SubscribeBloc(),
      child: SubscribeWidget(),
    );
  }
}

class SubscribeWidget extends StatefulWidget {
  SubscribeWidget({Key key}) : super(key: key);

  _SubscribeWidgetState createState() => _SubscribeWidgetState();
}

class _SubscribeWidgetState extends State<SubscribeWidget> with AutomaticKeepAliveClientMixin {

  SubscribeBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SubscribeBloc>(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.stream ,
      builder: (BuildContext context, AsyncSnapshot<List<JuDouModel>> snapshot) {
        List<JuDouModel> dataList = snapshot.data;
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(
            child: Loading(),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return JuDouCell(
              model: dataList[index],
              tag: 'DiscoveryPageSubscribe$index',
              divider: Blank(),
              isCell: true,
            );
          },
          itemCount: dataList.length,
          physics: AlwaysScrollableScrollPhysics(),
        );
      },
    );
  }


  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
  @override
  bool get wantKeepAlive => true;
}