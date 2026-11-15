import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/dio_client.dart';
import '../core/storage/hive_box.dart';
import '../core/utils/date_x.dart';

/// 在 main() 中打开 Hive 后覆盖；其余 provider 依赖它。
final Provider<CacheStore> cacheStoreProvider = Provider<CacheStore>(
  (ref) => throw UnimplementedError('cacheStoreProvider 必须在 ProviderScope 中覆盖'),
);

final Provider<Dio> dioProvider = Provider<Dio>(
  (ref) => createDio(cache: ref.watch(cacheStoreProvider)),
);

/// 赛季跟随本机年份，跨年自动切换，不需要发版。
final Provider<int> seasonProvider = Provider<int>(
  (ref) => seasonFor(DateTime.now()),
);