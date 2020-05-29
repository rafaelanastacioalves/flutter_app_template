
import 'dart:convert';

import 'package:flutter_app_template/http/http_config.dart';
import 'package:flutter_app_template/models/MainEntity.dart';

class WebClient {

  Future<List<MainEntity>> getMainEntityList() async {
    final String endPoint = "/trip-packages";
    String finalUrl = Http.url + endPoint;
    final response = await Http.client.post(finalUrl);

    if (response.statusCode == 200){
      final List<dynamic> decodedJson = json.decode(response.body);
      return decodedJson.map((item) => MainEntity.fromJson(item)).toList();
    }else{
      throw Exception("Http Exception");
    }

  }
}