
import 'dart:convert';

import 'package:flutter_app_template/models/EntityDetails.dart';
import 'package:flutter_app_template/models/MainEntity.dart';

import '../http_config.dart';

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

  Future<EntityDetails> getEntityDetail(String packageID) async {
    final String endPoint = "/trip-packages/$packageID";
    String finalUrl = Http.url + endPoint;
    final response = await Http.client.post(finalUrl);

    if (response.statusCode == 200){
      final dynamic decodedJson = json.decode(response.body);
      return EntityDetails.fromJson(decodedJson);
    }else{
      throw Exception("Http Exception");
    }

  }

}