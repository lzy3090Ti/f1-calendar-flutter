import 'package:dio/dio.dart';

/// 领域层错误，避免让 UI 直接依赖 DioException。
class Failure implements Exception {
  const Failure(this.message, {this.isOffline = false, this.cause});

  final String message;

  /// 网络不可用或超时，UI 可据此给出「检查网络」提示。
  final bool isOffline;

  final Object? cause;

  factory Failure.fromDio(DioException error) {
    final status = error.response?.statusCode;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure('请求超时，请稍后重试', isOffline: true, cause: error);
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
        return Failure('网络不可用，已展示本地缓存', isOffline: true, cause: error);
      case DioExceptionType.cancel:
        return Failure('请求已取消', cause: error);
      case DioExceptionType.badResponse:
        return Failure(
          '服务返回异常（$status），请稍后重试',
          cause: error,
        );
      case DioExceptionType.unknown:
      case DioExceptionType.transformTimeout:
        return Failure('网络请求失败，请检查网络连接', isOffline: true, cause: error);
    }
  }

  @override
  String toString() => message;
}

/// 缓存内容无法解析（结构变更或损坏）。
class CacheCorruptedException extends Failure {
  const CacheCorruptedException({super.cause})
      : super('本地缓存已失效，正在重新获取');
}