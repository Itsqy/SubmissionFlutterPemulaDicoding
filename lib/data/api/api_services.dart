import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helloflutter/data/model/resto_detail_responses.dart';
import 'package:helloflutter/data/model/resto_responses.dart';
import 'package:helloflutter/data/model/resto_search.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestoResponses> getAllResto() async {
    final response = await http.get(Uri.parse("${_baseUrl}/list"));
    debugPrint("all,${response.body}");
    if (response.statusCode == 200) {
      return RestoResponses.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to get data ");
    }
  }

  Future<RestoDetailResponses> getDetailresto(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}/detail/$id"));
    debugPrint("detail,${response.body}");
    if (response.statusCode == 200) {
      return RestoDetailResponses.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to get data ");
    }
  }

  Future<RestoSearchResponses> searchResto(String query) async {
    debugPrint("query : $query");
    final response = await http.get(Uri.parse("${_baseUrl}/search?q=$query"));
    debugPrint("search,${response.body}");
    if (response.statusCode == 200) {
      return RestoSearchResponses.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to get data ");
    }
  }
}
