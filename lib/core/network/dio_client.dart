import 'package:dio/dio.dart';

import '../storage/hive_box.dart';
import 'http_cache_interceptor.dart';

/// 统一的网络客户端：JSON + 超时 + 条件请求缓存拦截器。
Dio createDio({
  required CacheStore cache,
  String baseUrl = 'https://api.jolpi.ca/ergast/f1',
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 12),
      sendTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 20),
      responseType: ResponseType.json,
      headers: const <String, dynamic>{'Accept': 'application/json'},
      // 304 交给拦截器处理，其余 4xx/5xx 仍作为错误抛出。
      validateStatus: (status) => status != null && status < 400,
    ),
  )
    ..interceptors.add(HttpCacheInterceptor(cache))
    ..interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );
  return dio;
}