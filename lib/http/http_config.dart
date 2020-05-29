
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class Http {
  static final String url = 'https://private-ff953-template25.apiary-mock.com';

  static final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: Duration(seconds: 5),
  );
}
