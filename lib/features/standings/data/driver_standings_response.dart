import '../domain/driver_standing.dart';

/// `MRData.StandingsTable.StandingsLists[*].DriverStandings` 的解析器。
class DriverStandingsResponse {
  const DriverStandingsResponse({
    required this.rows,
    required this.round,
    required this.season,
  });

  final List<DriverStanding> rows;
  final String round;
  final String season;

  factory DriverStandingsResponse.fromJson(Map<String, dynamic> json) {
    final mrData = json['MRData'];
    final table = mrData is Map ? mrData['StandingsTable'] : null;
    final lists = table is Map ? table['StandingsLists'] : null;
    if (lists is! List || lists.isEmpty || lists.last is! Map) {
      return const DriverStandingsResponse(
        rows: <DriverStanding>[],
        round: '',
        season: '',
      );
    }

    final latest = Map<String, dynamic>.from(lists.last as Map);
    final rawRows = latest['DriverStandings'];
    final rows = rawRows is List
        ? rawRows
              .whereType<Map>()
              .map(
                (raw) => DriverStanding.fromJson(
                  _normalizeDriverStandingJson(Map<String, dynamic>.from(raw)),
                ),
              )
              .toList(growable: false)
        : const <DriverStanding>[];
    return DriverStandingsResponse(
      rows: rows,
      round: '${latest['round'] ?? ''}',
      season:
          '${latest['season'] ?? (table is Map ? table['season'] ?? '' : '')}',
    );
  }
}

Map<String, dynamic> _normalizeDriverStandingJson(Map<String, dynamic> raw) {
  final driver = raw['Driver'] ?? raw['driver'];
  final constructors = raw['Constructors'] ?? raw['constructors'];
  final constructor = raw['Constructor'] ??
      raw['constructor'] ??
      (constructors is List && constructors.isNotEmpty ? constructors.first : null);
  return <String, dynamic>{
    ...raw,
    'driver': driver,
    'constructor': constructor,
  };
}
