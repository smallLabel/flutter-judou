import 'package:flutter/material.dart';
import '../../network/network.dart';
import '../../index/models/judou_model.dart';

class SubscribeBloc implements BlocBase {
  final _fetchSubject = PublishSubject<List<JuDouModel>>();

  SubscribeBloc() {
    this._fetchData();
  }

  Stream<List<JuDouModel>> get stream => _fetchSubject.stream;

  @override
  void dispose() {
    if (!_fetchSubject.isClosed) {
        _fetchSubject.close();
    }
  }
  void _fetchData() async {

  }

}