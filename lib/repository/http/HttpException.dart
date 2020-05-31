import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HttpException implements Exception {
  final body;
  final int code;
  final Response response;

  HttpException({@required this.response})
  : body = response.body,
    code = response.statusCode;

}