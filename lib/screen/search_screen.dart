import 'package:flutter/material.dart';
import 'package:helloflutter/components/expanded_button.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/provider/resto_search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = "/search";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RestoSearchProvider(apiService: ApiService()),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Search Resto"),
            ),
            body: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        if (value != '') {
                          Provider.of<RestoSearchProvider>(
                            context,
                            listen: false,
                          ).getSearchData(value);
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter text here',
                        icon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
