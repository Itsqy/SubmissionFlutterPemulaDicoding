import 'package:flutter/material.dart';
import 'package:helloflutter/components/item_resto.dart';
import 'package:helloflutter/provider/database_provider.dart';
import 'package:helloflutter/provider/resto_provider.dart';
import 'package:provider/provider.dart';

class ListRestoSearch extends StatelessWidget {
  final Size screenSize;
  const ListRestoSearch(this.screenSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return Container(
            height: 500,
            width: screenSize.width,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var resto = state.result.restaurants[index];
                return ItemResto(
                  screenSize: screenSize,
                  restaurant: resto,
                );
              },
            ),
          );
        } else if (state.state == ResultState.noData) {
          return const Center(
            child: Material(
              child: Text("error : there is no data!"),
            ),
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("error : Check your connection please! "),
            ),
          );
        }
      },
    );
  }
}
