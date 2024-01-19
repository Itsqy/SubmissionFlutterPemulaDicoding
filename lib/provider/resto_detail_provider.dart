import 'package:flutter/material.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/data/model/resto_detail_responses.dart';

enum ResultState { loading, noData, hasData, error }

class RestoDetailProvider extends ChangeNotifier {
  String _msg = '';
  String get message => _msg;

  final String idDetail;
  final ApiService apiService;

  late RestoDetailResponses _restoDetailResult;
  late ResultState _state;

  RestoDetailResponses get result => _restoDetailResult;
  ResultState get state => _state;

  RestoDetailProvider({this.idDetail = '', required this.apiService}) {
    getdetail(idDetail);
  }

  Future<dynamic> getdetail(String idDetail) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restoDetail = await apiService.getDetailresto(idDetail);
      _state = ResultState.hasData;
      notifyListeners();
      return _restoDetailResult = restoDetail;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _msg =
          'kode error : $e koneksi anda tidak stabil , coba untuk gunakan jaringan yang stabil';
    }
  }
}
