import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloflutter/components/item_resto.dart';
import 'package:helloflutter/provider/database_provider.dart';
import 'package:helloflutter/utils/result_state.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite_screen';
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer<DatabaseProvider>(
      builder: (context, providerDb, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: const Text("My Favorits")),
            body: Consumer<DatabaseProvider>(
              builder: (_, value, __) {
                if (value.state == ResultState.hasData) {
                  debugPrint("${value.state}");
                  return ListView.builder(
                    itemCount: value.restoData.length,
                    itemBuilder: (context, index) {
                      final resto = value.restoData[index];
                      return Dismissible(
                        onDismissed: (direction) async {
                          value.removeFav(resto.id);
                          Fluttertoast.showToast(msg: "${resto.name} deleted");
                        },
                        key: Key(resto.id),
                        child: ItemResto(
                          screenSize: screenSize,
                          restaurant: resto,
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("has ${value.message}"),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
