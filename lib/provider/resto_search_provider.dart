import 'package:flutter/material.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/data/model/resto_search.dart';
import 'package:helloflutter/provider/resto_detail_provider.dart';

class RestoSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoSearchProvider({required this.apiService});

  ResultState? _state;
  ResultState? get state => _state;

  late String _msg = '';
  String get message => _msg;

  late RestoSearchResponses _restoSearchResponses;
  RestoSearchResponses get result => _restoSearchResponses;

  Future<dynamic> getSearchData(query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      var restoData = await apiService.searchResto(query);
      if (restoData.restaurants.isNotEmpty && restoData.founded != 0) {
        _state = ResultState.hasData;
        notifyListeners();
        return _restoSearchResponses = restoData;
      } else if (restoData.founded == 0) {
        _state = ResultState.noData;
        notifyListeners();
        return _msg = 'data tidak ditemukan';
      } else {
        _state = ResultState.loading;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _msg =
          "kode error : $e koneksi anda tidak stabil , coba untuk gunakan jaringan yang stabil";
    }
  }
}
