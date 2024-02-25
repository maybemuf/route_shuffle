import 'package:dio/dio.dart';

class ApiKeyParams {
  final String key;
  final String keyName;

  ApiKeyParams({
    required this.key,
    required this.keyName,
  });
}

class ApiKeyInterceptor extends Interceptor {
  final ApiKeyParams model;

  ApiKeyInterceptor({
    required this.model,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters[model.keyName] = model.key;
    super.onRequest(options, handler);
  }
}
