import 'package:flutter/material.dart';
import 'package:helloflutter/components/item_resto.dart';
import 'package:helloflutter/provider/resto_provider.dart';
import 'package:provider/provider.dart';

class ListResto extends StatelessWidget {
  final Size screenSize;
  const ListResto(this.screenSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestoProvider>(
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
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Text("no data"),
          );
        }
      },
    );
  }
}
