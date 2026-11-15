import 'dart:convert';

import '../../../core/storage/hive_box.dart';
import '../domain/race.dart';

/// 赛历本地缓存。保存已解析的模型 JSON，接口包装层变化不影响缓存可用性。
class RaceCache {
  RaceCache(this._store, {required this.season});

  final CacheStore _store;
  final int season;

  String get _key => 'race:calendar:$season';

  CachedPayload? readEntry() => _store.read(_key);

  Future<void> save(List<Race> races) {
    final body = jsonEncode(
      races.map((race) => race.toJson()).toList(growable: false),
    );
    return _store.write(
      _key,
      CachedPayload(body: body, fetchedAt: DateTime.now()),
    );
  }

  /// 解析缓存；结构损坏时返回 null，让上层重新拉取而不是崩溃。
  List<Race>? readRaces() {
    final entry = readEntry();
    if (entry == null) return null;
    try {
      final decoded = jsonDecode(entry.body);
      if (decoded is! List) return null;
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(Race.fromJson)
          .toList(growable: false);
    } on Object {
      return null;
    }
  }
}