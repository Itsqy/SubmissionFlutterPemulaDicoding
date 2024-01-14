import 'dart:convert';

import 'package:helloflutter/data/model/resto_search.dart';

RestoResponses restoResponsesFromJson(String str) =>
    RestoResponses.fromJson(json.decode(str));

String restoResponsesToJson(RestoResponses data) => json.encode(data.toJson());

class RestoResponses {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestoResponses({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestoResponses.fromJson(Map<String, dynamic> json) => RestoResponses(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
