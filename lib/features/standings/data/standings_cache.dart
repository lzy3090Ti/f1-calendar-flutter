import 'dart:convert';

import '../../../core/storage/hive_box.dart';
import '../domain/standing.dart';

/// 积分榜本地缓存 + 上一轮名次快照（用于计算名次变化箭头）。
class StandingsCache {
  StandingsCache(this._store, {required this.season});

  final CacheStore _store;
  final int season;

  String get _key => 'standings:table:$season';

  String get _positionsKey => 'standings:positions:$season';

  CachedPayload? readEntry() => _store.read(_key);

  Future<void> save(List<ConstructorStanding> rows) {
    final body = jsonEncode(
      rows.map((row) => row.toJson()).toList(growable: false),
    );
    return _store.write(
      _key,
      CachedPayload(body: body, fetchedAt: DateTime.now()),
    );
  }

  List<ConstructorStanding>? readStandings() {
    final entry = readEntry();
    if (entry == null) return null;
    try {
      final decoded = jsonDecode(entry.body);
      if (decoded is! List) return null;
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(ConstructorStanding.fromJson)
          .toList(growable: false);
    } on Object {
      return null;
    }
  }

  /// 车队 ID → 名次快照。
  Map<String, int> readPositions() {
    final raw = _store.read(_positionsKey);
    if (raw == null) return <String, int>{};
    try {
      final decoded = jsonDecode(raw.body);
      if (decoded is! Map<String, dynamic>) return <String, int>{};
      return decoded.map(
        (key, value) => MapEntry(key, value is int ? value : int.tryParse('$value') ?? 0),
      );
    } on Object {
      return <String, int>{};
    }
  }

  Future<void> savePositions(Map<String, int> positions) {
    return _store.write(
      _positionsKey,
      CachedPayload(
        body: jsonEncode(positions),
        fetchedAt: DateTime.now(),
      ),
    );
  }
}