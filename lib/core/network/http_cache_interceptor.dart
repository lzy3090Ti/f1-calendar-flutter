import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../storage/hive_box.dart';

/// HTTP 层缓存拦截器：
/// - 命中本地缓存时附加 `If-None-Match` / `If-Modified-Since` 条件请求；
/// - 服务端返回 304 时直接复用缓存正文，省流量；
/// - 200 响应把正文与校验器写回 Hive。
class HttpCacheInterceptor extends Interceptor {
  HttpCacheInterceptor(this._store);

  final CacheStore _store;

  String _key(RequestOptions options) => options.uri.toString();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final entry = _store.read(_key(options));
    if (entry != null) {
      final etag = entry.etag;
      if (etag != null && etag.isNotEmpty) {
        options.headers['If-None-Match'] = etag;
      }
      final lastModified = entry.lastModified;
      if (lastModified != null && lastModified.isNotEmpty) {
        options.headers['If-Modified-Since'] = lastModified;
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final data = response.data;
    if (response.statusCode == 200 && data is Map<String, dynamic>) {
      unawaited(_persist(response.requestOptions, data, response.headers));
    }
    handler.next(response);
  }

  Future<void> _persist(
    RequestOptions options,
    Map<String, dynamic> data,
    Headers headers,
  ) async {
    try {
      await _store.write(
        _key(options),
        CachedPayload(
          body: jsonEncode(data),
          fetchedAt: DateTime.now(),
          etag: headers.value('etag'),
          lastModified: headers.value('last-modified'),
        ),
      );
    } on Object {
      // 缓存写失败不影响本次请求结果。
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 304) {
      final key = _key(err.requestOptions);
      final entry = _store.read(key);
      if (entry != null) {
        final body = jsonDecode(entry.body);
        if (body is Map<String, dynamic>) {
          unawaited(_store.touch(key, DateTime.now()));
          handler.resolve(
            Response<dynamic>(
              requestOptions: err.requestOptions,
              statusCode: 200,
              statusMessage: 'Not Modified (served from cache)',
              data: body,
              headers: err.response?.headers,
            ),
          );
          return;
        }
      }
    }
    handler.next(err);
  }
}