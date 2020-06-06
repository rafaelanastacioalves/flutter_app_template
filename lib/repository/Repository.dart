import 'package:flutter/cupertino.dart';
import 'package:flutter_app_template/models/EntityDetails.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/models/Resource.dart';
import 'package:flutter_app_template/repository/database/main_entity_dao.dart';

import 'NetworkBoundResource.dart';
import 'database/main_entity_dao.dart';
import 'http/web_clients/web_client.dart';

class AppRepository {
  AppRepository({@required this.httpClient,
    @required this.dAO});

  final DAO dAO;
  final WebClient httpClient;

  Future<Resource<List<MainEntity>>> getMainEntityList() {
    var networkBoundResource =
        NetworkBoundResource<List<MainEntity>, List<MainEntity>>(
            getFromHttp: () => httpClient.getMainEntityList(),
            getFromDB: () => dAO.findAll(),
          saveIntoDB: (List<MainEntity> mainEntityList) => dAO.saveAll(mainEntityList)
        );

    return networkBoundResource.fetch();
  }

  Future<Resource<EntityDetails>> getEntityDetails(String id) {
    var networkBoundResource =
    NetworkBoundResource<EntityDetails, EntityDetails>(getFromHttp: () {
      return httpClient.getEntityDetail(id);
    });

    return networkBoundResource.fetch();
  }
}
