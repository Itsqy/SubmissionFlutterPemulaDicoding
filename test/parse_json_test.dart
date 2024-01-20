import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/data/model/resto_detail_responses.dart';
import 'package:helloflutter/data/model/resto_responses.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([http.Client])
void main() {
  const String detailRestoResponseMock = '''
  {
    "error": false,
    "message": "success",
    "restaurant": {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
      "city": "Medan",
      "address": "Jln. Pandeglang no 19",
      "pictureId": "14",
      "categories": [
        {
          "name": "Italia"
        },
        {
          "name": "Modern"
        }
      ],
      "menus": {
        "foods": [
          {
            "name": "Paket rosemary"
          },
          {
            "name": "Toastie salmon"
          }
        ],
        "drinks": [
          {
            "name": "Es krim"
          },
          {
            "name": "Sirup"
          }
        ]
      },
      "rating": 4.2,
      "customerReviews": [
        {
          "name": "Ahmad",
          "review": "Tidak rekomendasi untuk pelajar!",
          "date": "13 November 2019"
        }
      ]
    }
  }
  ''';
  group('should', () {
    test('returns a RestaurantResult when the HTTP call succeeds', () async {
      // Arrange: Set up the mock client with a successful response
      final mockResponse = {
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": []
      };
      final client = MockClient(
          (request) async => Response(json.encode(mockResponse), 200));

      // Act: Call the API method using the mock client
      final result = await ApiService(client).getAllResto();

      // Assert: Verify that the result is a RestaurantResult
      expect(result, isA<RestoResponses>());
    });
    test('parses JSON correctly for restaurant detail by ID', () async {
      // Arrange:
      const restaurantId = 'rqdv5juczeskfw1e867';
      final mockResponse = detailRestoResponseMock;
      final client = MockClient((request) async {
        if (request.url.path == '${ApiService.baseUrl}/detail/$restaurantId') {
          return Response(mockResponse, 200);
        } else {
          throw Exception('Unexpected request: ${request.url}');
        }
      });

      // Act:
      final result = await ApiService(client).getDetailresto(restaurantId);

      // Assert:
      expect(result, isA<RestoDetailResponses>());
    });
  });
}
