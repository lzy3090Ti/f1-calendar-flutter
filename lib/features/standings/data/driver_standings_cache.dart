import 'dart:convert';

import '../../../core/storage/hive_box.dart';
import '../domain/driver_standing.dart';

class DriverStandingsCache {
  DriverStandingsCache(this._store, {required this.season});

  final CacheStore _store;
  final int season;

  String get _key => 'standings:drivers:$season';

  CachedPayload? readEntry() => _store.read(_key);

  Future<void> save(List<DriverStanding> rows) => _store.write(
    _key,
    CachedPayload(
      body: jsonEncode(rows.map((row) => row.toJson()).toList()),
      fetchedAt: DateTime.now(),
    ),
  );

  List<DriverStanding>? readStandings() {
    final entry = readEntry();
    if (entry == null) return null;
    try {
      final decoded = jsonDecode(entry.body);
      if (decoded is! List) return null;
      return decoded
          .whereType<Map>()
          .map((row) => DriverStanding.fromJson(Map<String, dynamic>.from(row)))
          .toList(growable: false);
    } on Object {
      return null;
    }
  }
}
