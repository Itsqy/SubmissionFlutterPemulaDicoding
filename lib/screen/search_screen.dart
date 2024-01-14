import 'package:flutter/material.dart';
import 'package:helloflutter/components/item_resto.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/provider/resto_detail_provider.dart';
import 'package:helloflutter/provider/resto_search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = "/search";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (_) => RestoSearchProvider(apiService: ApiService()),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Search Resto"),
            ),
            body: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    Provider.of<RestoSearchProvider>(context, listen: false)
                        .getSearchData(value);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter text here',
                    icon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Consumer<RestoSearchProvider>(
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
                            child: Text(" "),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
