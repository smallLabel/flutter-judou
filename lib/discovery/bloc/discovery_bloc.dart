import 'package:flutter_judou/bloc_provider.dart';
import 'package:flutter_judou/discovery/models/topic_model.dart';
import 'package:flutter_judou/index/models/judou_model.dart';
import 'package:flutter_judou/index/models/tag_model.dart';
import 'package:flutter_judou/network/network.dart';

class DiscoveryBloc implements BlocBase {

  final _discoverySubject = PublishSubject<Map<String, dynamic>>();
  List<TopicModel> _topics;
  List<TagModel> tags;
  List<JuDouModel> _tagListData;

  Stream<Map<String, dynamic>> get stream => _discoverySubject.stream;

  DiscoveryBloc() {
    _fetchData();
  }

  void _fetchData() async {
      _topics = await Request.instance.dio
          .get(RequestPath.topicData())
          .then((response) => response.data['data'] as List)
          .then((response) => 
                response.map((item) => TopicModel.fromJson(item)).toList());
      tags = await Request.instance.dio
          .get(RequestPath.discoveryTags())
          .then((response) => response.data['data'] as List)
          .then((response) => 
              response.map((item) => TagModel.fromJSON(item)).toList());

      fetchTagListDataWithId('${tags[0].id}');
  }

  void fetchTagListDataWithId(String id) async {
    _tagListData = await Request.instance.dio
      .get(RequestPath.dataWithTagId(id))
      .then((response) => response.data['data'] as List)
      .then((response) => response.where((item) => !item['is_ad']))
      .then((response) => 
        response.map((item) => JuDouModel.fromJson(item)).toList());

    Map<String, dynamic> map = {
      'topics': _topics,
      'tags': tags,
      'tagListData': _tagListData
    };

    if (!_discoverySubject.isClosed) {
      _discoverySubject.sink.add(map);
    }
  }

  @override
  void dispose() { 
    if (!_discoverySubject.isClosed) {
      _discoverySubject.close();
    }
  }

}