import 'standing.dart';

/// 车队积分榜仓库接口。
abstract class StandingsRepository {
  Future<List<ConstructorStanding>?> readCachedStandings();

  Future<bool> isCacheStale();

  Future<List<ConstructorStanding>> getStandings({bool forceRefresh = false});
}
