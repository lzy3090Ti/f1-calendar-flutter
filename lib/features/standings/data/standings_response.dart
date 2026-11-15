import '../domain/standing.dart';

/// 车队积分榜响应包装：`MRData.StandingsTable.StandingsLists[*]`。
///
/// 赛季初接口可能返回空列表，因此每层都给出空值兜底。
class StandingsResponse {
  const StandingsResponse({
    required this.rows,
    required this.round,
    required this.season,
  });

  final List<ConstructorStanding> rows;
  final String round;
  final String season;

  bool get isEmpty => rows.isEmpty;

  factory StandingsResponse.fromJson(Map<String, dynamic> json) {
    final mrData = json['MRData'];
    if (mrData is! Map<String, dynamic>) {
      return const StandingsResponse(
        rows: <ConstructorStanding>[],
        round: '',
        season: '',
      );
    }
    final table = mrData['StandingsTable'];
    if (table is! Map<String, dynamic>) {
      return const StandingsResponse(
        rows: <ConstructorStanding>[],
        round: '',
        season: '',
      );
    }
    final lists = table['StandingsLists'];
    if (lists is! List || lists.isEmpty) {
      return StandingsResponse(
        rows: const <ConstructorStanding>[],
        round: '',
        season: table['season'] as String? ?? '',
      );
    }
    final latest = lists.last;
    if (latest is! Map<String, dynamic>) {
      return const StandingsResponse(
        rows: <ConstructorStanding>[],
        round: '',
        season: '',
      );
    }
    final rawRows = latest['ConstructorStandings'];
    final rows = rawRows is List
        ? rawRows
              .whereType<Map<String, dynamic>>()
              .map(_normalizeStandingJson)
              .map(ConstructorStanding.fromJson)
              .toList(growable: false)
        : const <ConstructorStanding>[];
    return StandingsResponse(
      rows: rows,
      round: latest['round'] as String? ?? '',
      season: latest['season'] as String? ?? '',
    );
  }
}

/// Jolpica 的车队对象字段名为 `Constructor`，而领域模型保持小写字段名。
Map<String, dynamic> _normalizeStandingJson(Map<String, dynamic> raw) {
  final constructorRaw = raw['Constructor'] ?? raw['constructor'];
  final constructor = constructorRaw is Map
      ? Map<String, dynamic>.from(constructorRaw)
      : <String, dynamic>{};

  return <String, dynamic>{...raw, 'constructor': constructor};
}
