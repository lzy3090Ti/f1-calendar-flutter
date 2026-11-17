import 'package:dio/dio.dart';

import '../../../core/error/failure.dart';
import '../domain/standing.dart';
import '../domain/standings_repository.dart';
import 'standings_api.dart';
import 'standings_cache.dart';

/// 车队积分榜仓库：远程接口 + 本地缓存（5 分钟）+ 名次变化计算。
class StandingsRepositoryImpl implements StandingsRepository {
  StandingsRepositoryImpl({
    required this.api,
    required this.cache,
    required this.season,
    this.cacheTtl = const Duration(minutes: 5),
  });

  final StandingsApi api;
  final StandingsCache cache;
  final String season;
  final Duration cacheTtl;

  @override
  Future<List<ConstructorStanding>?> readCachedStandings() async {
    final rows = cache.readStandings();
    if (rows == null) return null;
    return _decorate(rows, cache.readPositions());
  }

  @override
  Future<bool> isCacheStale() async {
    final entry = cache.readEntry();
    if (entry == null) return true;
    return !entry.isFresh(cacheTtl);
  }

  @override
  Future<List<ConstructorStanding>> getStandings({
    bool forceRefresh = false,
  }) async {
    final entry = cache.readEntry();
    final cached = cache.readStandings();
    final previousPositions = cache.readPositions();

    final hasUsableCache = cached != null && cached.isNotEmpty;
    if (!forceRefresh &&
        hasUsableCache &&
        (entry?.isFresh(cacheTtl) ?? false)) {
      return _decorate(cached, previousPositions);
    }

    try {
      final response = await api.fetchConstructorStandings(season);
      final rows = response.rows;
      if (rows.isNotEmpty) {
        await cache.save(rows);
        await cache.savePositions(<String, int>{
          for (final row in rows) row.constructorId: row.positionValue,
        });
      }
      return _decorate(rows, previousPositions);
    } on DioException catch (error) {
      if (hasUsableCache) return _decorate(cached, previousPositions);
      throw Failure.fromDio(error);
    }
  }

  /// 名次数字越小越靠前：previous - current > 0 表示上升。
  List<ConstructorStanding> _decorate(
    List<ConstructorStanding> rows,
    Map<String, int> previousPositions,
  ) {
    return rows
        .map((row) {
          final previous = previousPositions[row.constructorId];
          if (previous == null) return row;
          return row.copyWith(positionChange: previous - row.positionValue);
        })
        .toList(growable: false);
  }
}
