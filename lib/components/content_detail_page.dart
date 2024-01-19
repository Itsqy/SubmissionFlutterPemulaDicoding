import 'package:flutter/material.dart';
import 'package:helloflutter/components/expandable_text.dart';
import 'package:helloflutter/components/item_menu.dart';
import 'package:helloflutter/data/model/resto_search.dart';
import 'package:helloflutter/gen/fonts.gen.dart';
import 'package:helloflutter/provider/resto_detail_provider.dart';

class ContentDetailPage extends StatelessWidget {
  const ContentDetailPage({
    super.key,
    required this.restaurant,
    required this.provider,
  });

  final Restaurant restaurant;
  final RestoDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        Hero(
            tag: restaurant.pictureId,
            child: Image.network(
              "https://restaurant-api.dicoding.dev/images/small/${provider.result.restaurant.pictureId}",
              errorBuilder: (context, error, stackTrace) =>
                  const Text("Your connection not stable"),
            )),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                provider.result.restaurant.name,
                style: const TextStyle(
                    fontSize: 30,
                    fontFamily: FontFamily.poppins,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(Icons.map_outlined),
                  Text(
                    provider.result.restaurant.city,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.star),
                  Text(provider.result.restaurant.rating.toString()),
                ],
              ),
              ExpandableText(
                maxLines: 50,
                minLines: 3,
                text: provider.result.restaurant.description,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Foods",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                width: double.infinity / 2,
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: provider.result.restaurant.menus.foods.map((e) {
                    return itemMenu(e.name, "images/logo_mangga.png");
                  }).toList(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Drinnks",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                width: double.infinity / 2,
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: provider.result.restaurant.menus.drinks.map((e) {
                    return itemMenu(e.name, "images/logo_mangga.png");
                  }).toList(),
                ),
              ),
            ]))
      ]),
    ]);
  }
}
