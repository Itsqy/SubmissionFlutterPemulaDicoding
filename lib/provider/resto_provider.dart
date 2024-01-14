import 'package:flutter/material.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/data/model/resto_responses.dart';

enum ResultState { loading, noData, hasData, error }

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;
  RestoProvider({required this.apiService}) {
    _fetchAllResto();
  }

  late RestoResponses _restosResult;
  late ResultState _state;

  String _msg = '';
  String get message => _msg;

  RestoResponses get result => _restosResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllResto() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.getAllResto();
      if (resto.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _msg = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restosResult = resto;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _msg =
          'kode error : $e koneksi anda tidak stabil , coba untuk gunakan jaringan yang stabil';
    }
  }
}
