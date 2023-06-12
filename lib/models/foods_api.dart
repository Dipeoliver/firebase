import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/api_constants.dart';
import 'foods.dart';

class FoodsApi {
  static Future<List<Foods>> getRecipe(String countryKey) async {
    var uri = Uri.https(ApiConstants.baseUrl, ApiConstants.usersEndpoint,
        {"query": countryKey, ApiConstants.apiKey: ApiConstants.apiKeyValue});

    final response = await http.get(uri, headers: {
      ApiConstants.ContentType: ApiConstants.ContentTypeValue,
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i);
    }

    return Foods.recipesFromSnapshot(_temp);
  }
}
