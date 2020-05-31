import 'package:flutter_app_template/models/EntityDetails.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/models/Resource.dart';
import 'package:flutter_app_template/repository/database/main_entity_dao.dart';

import 'NetworkBoundResource.dart';
import 'http/web_clients/web_client.dart';

class AppRepository {
  Future<Resource<List<MainEntity>>> getMainEntityList() {
    final httpClient = WebClient();
    final dao = DAO();
    var networkBoundResource =
        NetworkBoundResource<List<MainEntity>, List<MainEntity>>(
            getFromHttp: () => httpClient.getMainEntityList(),
            getFromDB: () => dao.findAll(),
          saveIntoDB: (List<MainEntity> mainEntityList) => dao.saveAll(mainEntityList)
        );

    return networkBoundResource.fetch();
  }

  Future<Resource<EntityDetails>> getEntityDetails(String id) {
    final httpClient = WebClient();
    var networkBoundResource =
    NetworkBoundResource<EntityDetails, EntityDetails>(getFromHttp: () {
      return httpClient.getEntityDetail(id);
    });

    return networkBoundResource.fetch();
  }
}
