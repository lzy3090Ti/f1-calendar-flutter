import 'race.dart';

/// 赛历仓库接口（domain 层，不依赖 Flutter / Dio）。
abstract class RaceRepository {
  /// 仅读本地缓存，供「先显缓存」使用；缓存不存在或损坏时返回 null。
  Future<List<Race>?> readCachedRaces();

  /// 缓存是否已过期（无缓存视为过期）。
  Future<bool> isCacheStale();

  /// 取赛历。缓存新鲜时直接返回缓存；过期时先给缓存并由调用方决定后台刷新。
  Future<List<Race>> getRaces({bool forceRefresh = false});
}