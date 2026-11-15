import 'package:intl/intl.dart';

import '../../features/calendar/domain/race.dart';

/// 赛季推导：直接使用本机日历年份，跨年自动切换到新赛季，无需改代码。
int seasonFor(DateTime now) => now.year;

/// 倒计时拆解结果。
class CountdownParts {
  const CountdownParts({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  static CountdownParts fromDuration(Duration duration) {
    final total = duration.isNegative ? Duration.zero : duration;
    return CountdownParts(
      days: total.inDays,
      hours: total.inHours % 24,
      minutes: total.inMinutes % 60,
      seconds: total.inSeconds % 60,
    );
  }
}

extension RaceTimingX on Race {
  /// 比赛发车时间（本地时区）。日期缺失时返回 null。
  DateTime? get startsAtLocal => startsAtUtc?.toLocal();

  bool isFinishedAt(DateTime now) {
    final start = startsAtLocal;
    return start != null && !start.isAfter(now);
  }
}

extension RaceSessionTimingX on RaceSession {
  DateTime? get startsAtUtc {
    if (time == null || time!.isEmpty) return DateTime.tryParse(date);
    return DateTime.tryParse('${date}T$time');
  }

  DateTime? get startsAtLocal => startsAtUtc?.toLocal();
}

/// 取最近一场尚未开始的比赛；整季结束返回 null。
Race? nextRaceOf(Iterable<Race> races, DateTime now) {
  final ordered = races.where((race) => race.startsAtLocal != null).toList()
    ..sort((a, b) => a.startsAtLocal!.compareTo(b.startsAtLocal!));
  for (final race in ordered) {
    if (race.startsAtLocal!.isAfter(now)) return race;
  }
  return null;
}

Duration countdownTo(Race race, DateTime now) {
  final start = race.startsAtLocal;
  if (start == null) return Duration.zero;
  final delta = start.difference(now);
  return delta.isNegative ? Duration.zero : delta;
}

/// 按自然月分组，保持赛历原有顺序（接口已按 round 升序）。
Map<String, List<Race>> groupByMonth(Iterable<Race> races) {
  final grouped = <String, List<Race>>{};
  for (final race in races) {
    final start = race.startsAtLocal;
    if (start == null) continue;
    final label = formatMonthLabel(start);
    grouped.putIfAbsent(label, () => <Race>[]).add(race);
  }
  return grouped;
}

final DateFormat _monthDayFormat = DateFormat('M月d日', 'zh_CN');
final DateFormat _timeFormat = DateFormat('HH:mm', 'zh_CN');
final DateFormat _monthFormat = DateFormat('M月', 'zh_CN');
final DateFormat _fullFormat = DateFormat('yyyy年M月d日 HH:mm', 'zh_CN');

String formatMonthLabel(DateTime date) => _monthFormat.format(date);

String formatMonthDay(DateTime? date) =>
    date == null ? '待定' : _monthDayFormat.format(date);

String formatClock(DateTime? date) =>
    date == null ? '--:--' : _timeFormat.format(date);

String formatFullDateTime(DateTime? date) =>
    date == null ? '待定' : _fullFormat.format(date);
