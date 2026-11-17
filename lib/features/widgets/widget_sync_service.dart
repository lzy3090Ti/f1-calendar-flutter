import 'package:home_widget/home_widget.dart';

import '../calendar/domain/race.dart';
import '../calendar/domain/get_next_race.dart';
import '../standings/domain/driver_standing.dart';
import '../../shared/models/locale_labels.dart';

/// Flutter 与 Android 主屏小组件之间的轻量数据同步层。
class WidgetSyncService {
  static const driverIdKey = 'widget_driver_id';
  static const driverNameKey = 'widget_driver_name';
  static const driverTeamKey = 'widget_driver_team';
  static const driverPointsKey = 'widget_driver_points';
  static const driverColorKey = 'widget_driver_color';
  static const raceTitleKey = 'widget_race_title';
  static const raceLocationKey = 'widget_race_location';
  static const raceTargetKey = 'widget_race_target';

  static const driverProvider = 'com.f1calendar.app.F1DriverWidgetProvider';
  static const raceProvider = 'com.f1calendar.app.F1RaceWidgetProvider';

  static Future<void> saveSelectedDriver(String driverId) async {
    await HomeWidget.saveWidgetData<String>(driverIdKey, driverId);
  }

  static Future<void> syncDrivers(List<DriverStanding> rows) async {
    if (rows.isEmpty) return;
    final selected = await HomeWidget.getWidgetData<String>(driverIdKey);
    final row = rows.firstWhere(
      (item) => item.driver.driverId == selected,
      orElse: () => rows.first,
    );
    await Future.wait(<Future<void>>[
      HomeWidget.saveWidgetData<String>(
        driverIdKey,
        row.driver.driverId,
      ).then((_) {}),
      HomeWidget.saveWidgetData<String>(
        driverNameKey,
        row.driver.fullName,
      ).then((_) {}),
      HomeWidget.saveWidgetData<String>(
        driverTeamKey,
        row.constructor.name,
      ).then((_) {}),
      HomeWidget.saveWidgetData<String>(
        driverPointsKey,
        _formatPoints(row.pointsValue),
      ).then((_) {}),
      HomeWidget.saveWidgetData<String>(
        driverColorKey,
        _teamColor(row.constructorId),
      ).then((_) {}),
    ]);
    await HomeWidget.updateWidget(qualifiedAndroidName: driverProvider);
  }

  static Future<void> syncRace(List<Race> races) async {
    final next = const GetNextRace().call(races, DateTime.now());
    if (next == null || next.startsAtUtc == null) {
      await HomeWidget.saveWidgetData<String>(raceTitleKey, '本赛季已结束');
      await HomeWidget.saveWidgetData<String>(raceLocationKey, '');
      await HomeWidget.saveWidgetData<int>(raceTargetKey, 0);
    } else {
      await Future.wait(<Future<void>>[
        HomeWidget.saveWidgetData<String>(
          raceTitleKey,
          raceTitleZh(next),
        ).then((_) {}),
        HomeWidget.saveWidgetData<String>(
          raceLocationKey,
          '${localityZh(next.locality)} · ${next.circuit.circuitName}',
        ).then((_) {}),
        HomeWidget.saveWidgetData<int>(
          raceTargetKey,
          next.startsAtUtc!.millisecondsSinceEpoch,
        ).then((_) {}),
      ]);
    }
    await HomeWidget.updateWidget(qualifiedAndroidName: raceProvider);
  }

  static String _formatPoints(double points) {
    return points == points.roundToDouble()
        ? points.toInt().toString()
        : points.toStringAsFixed(1);
  }

  static String _teamColor(String constructorId) {
    const colors = <String, String>{
      'mercedes': '#00D2BE',
      'ferrari': '#E8002D',
      'red_bull': '#3671C6',
      'mclaren': '#FF8000',
      'rb': '#6692FF',
      'alpine': '#FF87BC',
      'haas': '#B6BABD',
      'audi': '#BB0A30',
      'williams': '#00A0DE',
      'aston_martin': '#229971',
      'cadillac': '#C9A227',
    };
    return colors[constructorId] ?? '#0067C0';
  }
}
