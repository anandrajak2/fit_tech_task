import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:task_project_16/models/userListResponse.dart';
// Import your application code

void main() {
  // Sample JSON data to test parsing
  final sampleJson = {
    "results": [
      {
        "gender": "female",
        "name": {"title": "Ms", "first": "Enora", "last": "Brun"},
        "location": {
          "street": {"number": 7527, "name": "Rue Dugas-Montbel"},
          "city": "Avignon",
          "state": "La Réunion",
          "country": "France",
          "postcode": 33741,
          "coordinates": {"latitude": "-17.9353", "longitude": "68.2590"},
          "timezone": {
            "offset": "0:00",
            "description": "Western Europe Time, London, Lisbon, Casablanca"
          }
        },
        "email": "enora.brun@example.com",
        "login": {
          "uuid": "51d7cd28-40e4-40d2-9660-703a03f75892",
          "username": "angrykoala150",
          "password": "halifax",
          "salt": "a6sbZjxA",
          "md5": "9cc9ece47f04d93d522da5632c33b93e",
          "sha1": "204044a8bb289a1adc9dfaaf7315d96246227e0d",
          "sha256":
              "25022e88f1857f26aaeeecf5cf7f8e869bc0e4ce5e3f7d3e8736d91e3c971455"
        },
        "dob": {"date": "1955-07-05T20:07:03.814Z", "age": 68},
        "registered": {"date": "2015-06-17T22:48:01.009Z", "age": 8},
        "phone": "02-94-35-61-04",
        "cell": "06-52-24-08-18",
        "id": {"name": "INSEE", "value": "2550671378616 15"},
        "picture": {
          "large": "https://randomuser.me/api/portraits/women/1.jpg",
          "medium": "https://randomuser.me/api/portraits/med/women/1.jpg",
          "thumbnail": "https://randomuser.me/api/portraits/thumb/women/1.jpg"
        },
        "nat": "FR"
      }
    ],
    "info": {
      "seed": "169681aa0179816d",
      "results": 1,
      "page": 1,
      "version": "1.4"
    }
  };

  test('Test JSON parsing', () {
    // Parse the JSON and create a UsersListModel instance
    final usersListModel = usersListModelFromJson(jsonEncode(sampleJson));

    expect(usersListModel, isNotNull);

    // Validate properties of the parsed object
    expect(usersListModel.results.length, 1);
    expect(usersListModel.results[0].name.first, "Enora");
    expect(usersListModel.results[0].location.city, "Avignon");
  });
}
