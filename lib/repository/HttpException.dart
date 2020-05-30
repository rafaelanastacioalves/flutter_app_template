import 'package:http/http.dart';

class HttpException implements Exception {
  final body;
  final int code;
  final Response response;

  HttpException(this.response)
  : body = response.body,
    code = response.statusCode;

}