import 'package:freezed_annotation/freezed_annotation.dart';

part 'race.freezed.dart';
part 'race.g.dart';

/// 一场大奖赛。字段口径来自 Jolpica-F1（Ergast 兼容）赛历接口。
@freezed
abstract class Race with _$Race {
  const Race._();

  const factory Race({
    required String season,
    required String round,
    required String raceName,
    required Circuit circuit,
    required String date,
    String? time,
    @JsonKey(name: 'FirstPractice') RaceSession? firstPractice,
    @JsonKey(name: 'SecondPractice') RaceSession? secondPractice,
    @JsonKey(name: 'ThirdPractice') RaceSession? thirdPractice,
    @JsonKey(name: 'Qualifying') RaceSession? qualifying,
    @JsonKey(name: 'Sprint') RaceSession? sprint,
    @JsonKey(name: 'SprintQualifying') RaceSession? sprintQualifying,
  }) = _Race;

  factory Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);

  /// 发车时间（UTC）。部分分站只给日期不带时间。
  DateTime? get startsAtUtc {
    final sessionTime = time;
    if (sessionTime == null || sessionTime.isEmpty) {
      return DateTime.tryParse(date);
    }
    return DateTime.tryParse('${date}T$sessionTime');
  }

  /// 是否冲刺赛周末。接口用是否存在 Sprint 节点表达，不做站数硬编码。
  bool get isSprintWeekend => sprint != null;

  int get roundNumber => int.tryParse(round) ?? 0;

  String get country => circuit.location.country;

  String get locality => circuit.location.locality;
}

/// 练习赛/冲刺赛等分站内场次。
@freezed
abstract class RaceSession with _$RaceSession {
  const factory RaceSession({required String date, String? time}) =
      _RaceSession;

  factory RaceSession.fromJson(Map<String, dynamic> json) =>
      _$RaceSessionFromJson(json);
}

@freezed
abstract class Circuit with _$Circuit {
  const Circuit._();

  const factory Circuit({
    required String circuitId,
    required String circuitName,
    required CircuitLocation location,
  }) = _Circuit;

  factory Circuit.fromJson(Map<String, dynamic> json) =>
      _$CircuitFromJson(json);

  String get country => location.country;

  String get locality => location.locality;
}

@freezed
abstract class CircuitLocation with _$CircuitLocation {
  const factory CircuitLocation({
    required String lat,
    required String long,
    required String locality,
    required String country,
  }) = _CircuitLocation;

  factory CircuitLocation.fromJson(Map<String, dynamic> json) =>
      _$CircuitLocationFromJson(json);
}
