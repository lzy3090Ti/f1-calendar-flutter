import 'package:dio/dio.dart';

import '../../../core/error/failure.dart';
import '../domain/race.dart';
import '../domain/race_repository.dart';
import 'race_api.dart';
import 'race_cache.dart';

/// 赛历仓库：远程接口 + 本地缓存组合。
///
/// 缓存有效期写在仓库层（赛历 24 小时），UI 不感知 TTL。
class RaceRepositoryImpl implements RaceRepository {
  RaceRepositoryImpl({
    required this.api,
    required this.cache,
    required this.season,
    this.cacheTtl = const Duration(hours: 24),
  });

  final RaceApi api;
  final RaceCache cache;
  final String season;
  final Duration cacheTtl;

  @override
  Future<List<Race>?> readCachedRaces() async => cache.readRaces();

  @override
  Future<bool> isCacheStale() async {
    final entry = cache.readEntry();
    if (entry == null) return true;
    return !entry.isFresh(cacheTtl);
  }

  @override
  Future<List<Race>> getRaces({bool forceRefresh = false}) async {
    final entry = cache.readEntry();
    final cached = cache.readRaces();

    final hasUsableCache = cached != null && cached.isNotEmpty;
    if (!forceRefresh && hasUsableCache && (entry?.isFresh(cacheTtl) ?? false)) {
      return cached;
    }

    try {
      final response = await api.fetchSeasonRaces(season);
      final races = response.mrData.races;
      // 空数据通常是赛季尚未排期，不写入缓存以免长期返回空列表。
      if (races.isNotEmpty) {
        await cache.save(races);
      }
      return races;
    } on DioException catch (error) {
      if (hasUsableCache) return cached;
      throw Failure.fromDio(error);
    }
  }
}