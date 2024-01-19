import 'package:flutter/material.dart';
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
    final restoDetailProvider =
        Provider.of<RestoDetailProvider>(context, listen: false);
    restoDetailProvider.getdetail(restaurant.id);
//  buat consumer untu databaseprovider di sini , sehingga bisa dipake untuk FAB
    return Consumer<DatabaseProvider>(builder: (_, provider, __) {
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('telah ditambahkan'),
                              duration: Duration(seconds: 1),
                            ),
                          );
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
                child: Consumer<RestoDetailProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == ResultState.hasData) {
                      return ContentDetailPage(
                        restaurant: restaurant,
                        provider: restoDetailProvider,
                      );
                    } else if (state.state == ResultState.noData) {
                      return const Center(
                        child: Material(
                          child: Text("error :there is no data!"),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("error :Check your connection please!"),
                      );
                    }
                  },
                ),
              ),
            );
          });
    });
  }
}
