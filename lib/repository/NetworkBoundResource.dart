import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/models/Resource.dart';

import 'http/HttpException.dart';

class NetworkBoundResource<ResultType, RequestType> {
  NetworkBoundResource({@required this.getFromHttp, this.getFromDB, this.saveIntoDB});

  Resource<ResultType> _result;

  Future<ResultType> Function() getFromHttp;

  Future<ResultType> Function() getFromDB;

  Future Function(ResultType) saveIntoDB;

  Future<Resource<ResultType>> fetch() async {
    if (saveIntoDB == null || getFromDB == null) {
      await _fetchFromNetwork();
    }else{
      await _fetchFromNetworkAndDB();
    }
    return _result;
  }

  _fetchFromNetwork() async {
    ResultType resultData;
    try {
      resultData = await getFromHttp();
      _result = Resource.success(resultData);
    } catch (e) {
      if (e is HttpException) {
        treatHttpExcpetion(e);
      } else {
        _result = Resource.error(Status.GENERIC_ERROR, message: e.toString());
      }
    }
  }

  _fetchFromNetworkAndDB() async {
    var localData;
    try {
      ResultType localData = await getFromDB();
      if (localData != null) {
        _result = Resource.success(localData);
      } else {
        ResultType resultData = await getFromHttp();
        await saveIntoDB(resultData);
        _result = Resource.success(await getFromDB());
      }
    } catch (e) {
      if (e is HttpException) {
        treatHttpExcpetion(e);
      }else{
        _result = Resource.error(Status.GENERIC_ERROR, message: e.toString());
      }
      ;
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
