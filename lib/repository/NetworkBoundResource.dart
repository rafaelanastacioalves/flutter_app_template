import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/models/Resource.dart';

import 'HttpException.dart';

class NetworkBoundResource<ResultType, RequestType> {
  NetworkBoundResource({@required this.fetchFromHttp, this.fetchFromDB});

  Resource<ResultType> _result;

  Future<ResultType> Function() fetchFromHttp;

  Future<ResultType> Function() fetchFromDB;

  Future Function(ResultType) saveIntoDB;

  Future<Resource<ResultType>> fetch() async {
    await _fetchFromNetwork();
    return _result;
  }

  _fetchFromNetwork() async {
    ResultType resultData;
    try {
      resultData = await fetchFromHttp();
      _result = Resource.success(resultData);
    } catch (e) {
      if (e is HttpException) {
        treatHttpExcpetion(e);
      } else {
        _result = Resource.error(Status.GENERIC_ERROR);
      }
    }
  }

  treatHttpExcpetion(HttpException e) {
    switch (e.code) {
      case HttpStatus.internalServerError:
        _result = Resource.error(Status.INTERNAL_SERVER_ERROR);
        break;
      default:
        _result = Resource.error(Status.GENERIC_ERROR);
    }
  }
}
