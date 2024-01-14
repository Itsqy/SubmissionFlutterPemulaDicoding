import 'dart:convert';

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

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
