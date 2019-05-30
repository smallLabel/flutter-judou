import 'package:flutter/material.dart';
import 'package:flutter_judou/index/pages/detail_page.dart';
import '../../network/network.dart';
import '../models/judou_model.dart';

class Indexbloc implements BlocBase {
  /// 存放所有的model
  final _fetchDaily = PublishSubject<List<JuDouModel>>();

  /// 顶部的角标数据
  /// [0] 评论数
  /// [1] 喜欢数
  /// [2] ‘1’ 喜欢  ‘0’ 不喜欢
  final _badges = PublishSubject<List<String>>();
  JuDouModel model = JuDouModel();
  List<JuDouModel> _dataList = List<JuDouModel>();

  Indexbloc() {
    _fetchDailyJson();
  }
  /// 每日数据
  Stream<List<JuDouModel>> get dailyStream => _fetchDaily.stream;
	/// 角标数据，好像是每次都要获取？
	Stream<List<String>> get badgesStream => _badges.stream;

	void onPageChanged(index) {
		model = _dataList[index];
		double likeNum = model.likeCount / 1000;
		double commentNum = model.commentCount / 1000;
		String likeCount = 
				( likeNum > 1 ) ? likeNum.toStringAsFixed(1) + 'k' : '${model.likeCount}';
		String commentCount = 
				( commentNum > 1) ? commentNum.toStringAsFixed(1) + 'k' : '${model.commentCount}';

		if (!_badges.isClosed) {
			_badges.sink.add([likeCount, commentCount, model.isLiked ? '1' : '0']);
		}
	}

  void toDetailPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(model: model,)));
  }

  void _fetchDailyJson() async {
    List<JuDouModel> dataList = await daily();
    if (!_fetchDaily.isClosed) {
      _fetchDaily.sink.add(dataList);
    }
    _dataList = dataList;
    this.onPageChanged(0);
  }
  /// 首页网络请求
  Future<List<JuDouModel>> daily() async {
    List<JuDouModel> list = await Request.instance.dio
        .get(RequestPath.daily)
        .then((response) => response.data['data'] as List)
        .then((response) => response.where((item) => !item['is_ad']).toList())
        .then((response) => 
            response.map((item) => JuDouModel.fromJson(item)).toList());
    return list;
  }
  


  @override
  void dispose() {
    if (!_fetchDaily.isClosed) {
      _fetchDaily.close();
    }
    if (_badges.isClosed) {
      _badges.close();
    }
  }
}