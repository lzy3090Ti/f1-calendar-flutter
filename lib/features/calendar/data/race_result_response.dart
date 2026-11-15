import '../domain/race_result.dart';

/// Jolpica 分站正赛结果响应：`MRData.RaceTable.Races[0].Results`。
class RaceResultsResponse {
  const RaceResultsResponse({required this.results});

  final List<RaceResult> results;

  factory RaceResultsResponse.fromJson(Map<String, dynamic> json) {
    final mrData = json['MRData'];
    if (mrData is! Map<String, dynamic>) {
      return const RaceResultsResponse(results: <RaceResult>[]);
    }
    final table = mrData['RaceTable'];
    if (table is! Map<String, dynamic>) {
      return const RaceResultsResponse(results: <RaceResult>[]);
    }
    final races = table['Races'];
    if (races is! List ||
        races.isEmpty ||
        races.first is! Map<String, dynamic>) {
      return const RaceResultsResponse(results: <RaceResult>[]);
    }
    final rawResults = (races.first as Map<String, dynamic>)['Results'];
    if (rawResults is! List) {
      return const RaceResultsResponse(results: <RaceResult>[]);
    }

    return RaceResultsResponse(
      results: rawResults
          .whereType<Map<String, dynamic>>()
          .map(_parseResult)
          .toList(growable: false),
    );
  }
}

RaceResult _parseResult(Map<String, dynamic> raw) {
  final driver = raw['Driver'] is Map
      ? Map<String, dynamic>.from(raw['Driver'] as Map)
      : const <String, dynamic>{};
  final constructor = raw['Constructor'] is Map
      ? Map<String, dynamic>.from(raw['Constructor'] as Map)
      : const <String, dynamic>{};
  final givenName = driver['givenName'] as String? ?? '';
  final familyName = driver['familyName'] as String? ?? '';

  return RaceResult(
    position: raw['position'] as String? ?? '',
    positionText:
        raw['positionText'] as String? ?? raw['position'] as String? ?? '',
    points: raw['points'] as String? ?? '0',
    driverId: driver['driverId'] as String? ?? '',
    driverName: [
      givenName,
      familyName,
    ].where((name) => name.isNotEmpty).join(' '),
    constructorId: constructor['constructorId'] as String? ?? '',
    constructorName: constructor['name'] as String? ?? '',
    status: raw['status'] as String? ?? '',
  );
}
