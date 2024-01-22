import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloflutter/components/content_detail_page.dart';
import 'package:helloflutter/data/model/resto_search.dart';
import 'package:helloflutter/provider/database_provider.dart';
import 'package:helloflutter/provider/resto_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detailRestaurant";
  final Restaurant restaurant;
  const DetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final restoDetailProvider =
          Provider.of<RestoDetailProvider>(context, listen: false);
      restoDetailProvider.getdetail(restaurant.id);
    });

    return Consumer2<DatabaseProvider, RestoDetailProvider>(
        builder: (_, provider, state, __) {
      return FutureBuilder(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndFloat,
              floatingActionButton: isFavorite
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          debugPrint("data dihapus");
                          provider.removeFav(restaurant.id);
                          Fluttertoast.showToast(
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor:
                                  const Color.fromARGB(255, 164, 18, 8),
                              textColor: Colors.white,
                              fontSize: 16.0,
                              msg: 'Item removed from your Favorite');
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ))
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red,
                      ),
                      child: IconButton(
                        onPressed: () {
                          debugPrint("data add");
                          provider.addFav(Restaurant(
                              id: restaurant.id,
                              name: restaurant.name,
                              description: restaurant.description,
                              pictureId: restaurant.pictureId,
                              city: restaurant.city,
                              rating: restaurant.rating));
                          Fluttertoast.showToast(
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor:
                                  const Color.fromARGB(255, 164, 18, 8),
                              textColor: Colors.white,
                              fontSize: 16.0,
                              msg: 'item added to favorite');
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
              appBar: AppBar(
                title: Text(restaurant.name),
              ),
              body: SingleChildScrollView(
                child: switch (state.state) {
                  ResultState.loading =>
                    const Center(child: CircularProgressIndicator()),
                  ResultState.hasData =>
                    ContentDetailPage(restaurant: restaurant, provider: state),
                  ResultState.noData =>
                    const Center(child: Text('error : there is no data ')),
                  ResultState.error =>
                    const Center(child: Text('error : check your connection ')),
                },
              ),
            );
          });
    });
  }
}
