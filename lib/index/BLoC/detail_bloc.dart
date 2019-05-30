import '../../network/network.dart';
import 'package:flutter_judou/network/network.dart';
import '../../bloc_provider.dart';
import '../models/comment_model.dart';
import '../models/judou_model.dart';


class DetailBloc implements BlocBase {
  final _fetchComment = PublishSubject<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get commentStream => _fetchComment.stream;

  final String uuid;

  DetailBloc({this.uuid}) {
    _fetchData();
  }

  void _fetchData() async {
    Map<String, dynamic> hot = await sentenceHot(uuid);
    if (!_fetchComment.isClosed) {
      _fetchComment.sink.add(hot);
    }
  }

  Future<Map<String, dynamic>> sentenceHot(String  uuid) async {
    List<CommentModel> hot = await Request.instance.dio
      .get(RequestPath.sentenceHot(uuid))
      .then((response) => response.data['data'] as List)
      .then((response) => response.map((item) => CommentModel.fromJSON(item)).toList());
    List<CommentModel> latest = await Request.instance.dio
      .get(RequestPath.sentenceLatest(uuid))
      .then((response) => response.data['data'] as List)
      .then((response) => response.map((item) => CommentModel.fromJSON(item)).toList());
    JuDouModel detailModel = await Request.instance.dio
        .get(RequestPath.sentence(uuid))
        .then((response) => JuDouModel.fromJson(response.data));
    
    return {'hot': hot, 'latest': latest, 'detail': detailModel};
  }

  @override
  void dispose() {
    if (!_fetchComment.isClosed) {
      _fetchComment.close();
    }
  }
  
}