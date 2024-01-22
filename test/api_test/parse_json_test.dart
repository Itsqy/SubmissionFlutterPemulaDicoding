import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/data/model/resto_detail_responses.dart';
import 'package:helloflutter/data/model/resto_responses.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'parse_json_test.mocks.dart' as mockClient;
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
  group('parsed json test', () {
    test('returns a RestaurantResult when the HTTP call succeeds', () async {
      final mockResponse = {
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": []
      };
      final client = MockClient(
          (request) async => Response(json.encode(mockResponse), 200));
      final result = await ApiService(client).getAllResto();

      expect(result, isA<RestoResponses>());
    });
    test('parses JSON correctly for restaurant detail by ID', () async {
      const restaurantId = 'rqdv5juczeskfw1e867';
      const mockResponse = detailRestoResponseMock;
      final mockClient.MockClient clientMock = mockClient.MockClient();
      when(clientMock
              .get(Uri.parse('${ApiService.baseUrl}/detail/$restaurantId')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await ApiService(clientMock).getDetailresto(restaurantId);

      expect(result, isA<RestoDetailResponses>());
    });
  });
}
