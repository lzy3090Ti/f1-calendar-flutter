import '../../../core/utils/date_x.dart';
import 'race.dart';

/// 「下一场比赛」用例：不必额外接口，用整季赛历按本地时间过滤即可。
class GetNextRace {
  const GetNextRace();

  Race? call(List<Race> races, DateTime now) => nextRaceOf(races, now);
}