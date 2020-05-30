import 'package:flutter_app_template/models/EntityDetails.dart';
import 'package:flutter_app_template/models/Resource.dart';

import 'NetworkBoundResource.dart';
import 'http/web_clients/web_client.dart';

class AppRepository {
  Future<Resource<EntityDetails>> getEntityDetails(String id) {
    final httpClient = WebClient();
    var networkBoundResource =
        NetworkBoundResource<EntityDetails, EntityDetails>(fetchFromHttp: () {
      return httpClient.getEntityDetail(id);
    });

    return networkBoundResource.fetch();
  }
}
