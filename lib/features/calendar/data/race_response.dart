import '../domain/race.dart';

/// 赛历接口响应包装：`MRData.RaceTable.Races`。
///
/// 纯传输对象，手写解析以避免生成器对嵌套列表字段的额外约束。
class RaceTableResponse {
  const RaceTableResponse({required this.mrData});

  final RaceMrData mrData;

  factory RaceTableResponse.fromJson(Map<String, dynamic> json) {
    final mrData = json['MRData'];
    return RaceTableResponse(
      mrData: mrData is Map<String, dynamic>
          ? RaceMrData.fromJson(mrData)
          : const RaceMrData(races: <Race>[], season: ''),
    );
  }
}

class RaceMrData {
  const RaceMrData({required this.races, required this.season});

  final List<Race> races;
  final String season;

  factory RaceMrData.fromJson(Map<String, dynamic> json) {
    final table = json['RaceTable'];
    if (table is! Map<String, dynamic>) {
      return const RaceMrData(races: <Race>[], season: '');
    }
    final rawRaces = table['Races'];
    final races = rawRaces is List
        ? rawRaces
              .whereType<Map<String, dynamic>>()
              .map(_normalizeRaceJson)
              .map(Race.fromJson)
              .toList(growable: false)
        : const <Race>[];
    return RaceMrData(races: races, season: table['season'] as String? ?? '');
  }
}

/// Jolpica 保持 Ergast 的响应字段名，嵌套对象使用首字母大写：
/// `Circuit` / `Location`。领域模型使用 Dart 风格的小写字段名，
/// 因此在接口边界统一一次，避免把外部协议细节带进 domain 层。
Map<String, dynamic> _normalizeRaceJson(Map<String, dynamic> raw) {
  final circuitRaw = raw['Circuit'] ?? raw['circuit'];
  final circuit = circuitRaw is Map
      ? Map<String, dynamic>.from(circuitRaw)
      : <String, dynamic>{};
  final locationRaw = circuit['Location'] ?? circuit['location'];
  final location = locationRaw is Map
      ? Map<String, dynamic>.from(locationRaw)
      : <String, dynamic>{};

  return <String, dynamic>{
    ...raw,
    'circuit': <String, dynamic>{...circuit, 'location': location},
  };
}
