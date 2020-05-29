import 'dart:convert';

import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  Future<List<MainEntity>> getMainEntityList() async {
    final response = await http
        .post('https://private-ff953-template25.apiary-mock.com/trip-packages');

    final List<dynamic> decodedJson = json.decode(response.body);
    return decodedJson.map((item) => MainEntity.fromJson(item)).toList();
  }
}
