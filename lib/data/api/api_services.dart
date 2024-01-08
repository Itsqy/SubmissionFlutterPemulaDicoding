import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:helloflutter/data/api/resto_responses.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestoResponses> getAllResto() async {
    final response = await http.get(Uri.parse("${_baseUrl}/list"));
    print(response);
    debugPrint("loading,${response.body}");
    if (response.statusCode == 200) {
      return RestoResponses.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to get data ");
    }
  }
}
