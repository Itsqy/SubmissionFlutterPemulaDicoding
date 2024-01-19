import 'package:flutter/cupertino.dart';
import 'package:helloflutter/data/db/database_helper.dart';
import 'package:helloflutter/data/model/resto_search.dart';
import 'package:helloflutter/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorits();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _restoData = [];
  List<Restaurant> get restoData => _restoData;

  void _getFavorits() async {
    _restoData = await databaseHelper.getAllFav();
    if (_restoData.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFav(Restaurant restaurant) async {
    try {
      await databaseHelper.addFavorit(restaurant);
      _getFavorits();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String url) async {
    final favResto = await databaseHelper.getFavByUrl(url);
    return favResto.isNotEmpty;
  }

  void removeFav(String url) async {
    try {
      await databaseHelper.removeBookmark(url);
      _getFavorits();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
