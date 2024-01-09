import 'package:flutter/material.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/data/model/resto_responses.dart';
import 'package:helloflutter/gen/fonts.gen.dart';
import 'package:helloflutter/provider/resto_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detailRestaurant";
  final Restaurant restaurant;
  const DetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoDetailProvider>(
      create: (_) => RestoDetailProvider(
          apiService: ApiService(), idDetail: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurant.id),
        ),
        body: SingleChildScrollView(
          child: Consumer<RestoDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.state == ResultState.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/small/${state.result.restaurant.pictureId}",
                          errorBuilder: (context, error, stackTrace) =>
                              const Text("Your connection not stable"),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.result.restaurant.name,
                            style: const TextStyle(
                                fontSize: 30,
                                fontFamily: FontFamily.poppins,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.map_outlined),
                              Text(
                                state.result.restaurant.city,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star),
                              Text(state.result.restaurant.rating.toString()),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              state.result.restaurant.description,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Foods",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (state.state == ResultState.noData) {
                return Center(
                  child: Material(
                    child: Text(state.message),
                  ),
                );
              } else {
                return const Center(
                  child: Text("else "),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
