import 'dart:io';

import 'package:f1_calendar/app/theme.dart';
import 'package:f1_calendar/features/calendar/domain/race.dart';
import 'package:f1_calendar/features/calendar/presentation/next_race_card.dart';
import 'package:f1_calendar/features/calendar/presentation/race_list_tile.dart';
import 'package:f1_calendar/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// Generate deterministic README images from real app widgets:
// flutter test tool/capture_readme_previews_test.dart --update-goldens
Future<ByteData> _fontBytes(String path) async {
  final bytes = await File(path).readAsBytes();
  return ByteData.sublistView(bytes);
}

Race _race({
  required String round,
  required String name,
  required String circuitId,
  required String circuit,
  required String locality,
  required String country,
  required String date,
  required String time,
  bool sprint = false,
}) {
  return Race(
    season: '2026',
    round: round,
    raceName: name,
    circuit: Circuit(
      circuitId: circuitId,
      circuitName: circuit,
      location: CircuitLocation(
        lat: '0',
        long: '0',
        locality: locality,
        country: country,
      ),
    ),
    date: date,
    time: time,
    sprint: sprint
        ? const RaceSession(date: '2026-03-14', time: '03:00:00Z')
        : null,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    Intl.defaultLocale = 'zh_CN';
    await initializeDateFormatting('zh_CN');

    await (FontLoader(
      'Roboto',
    )..addFont(_fontBytes('/System/Library/Fonts/Hiragino Sans GB.ttc'))).load();

    final flutterRoot = Platform.environment['FLUTTER_ROOT'];
    if (flutterRoot != null) {
      await (FontLoader('MaterialIcons')..addFont(
            _fontBytes(
              '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
            ),
          ))
          .load();
    }
  });

  for (final brightness in Brightness.values) {
    testWidgets('capture ${brightness.name} README preview', (tester) async {
      tester.view.physicalSize = const Size(430, 860);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final now = DateTime(2026, 11, 20, 12);
      final china = _race(
        round: '2',
        name: 'Chinese Grand Prix',
        circuitId: 'shanghai',
        circuit: 'Shanghai International Circuit',
        locality: 'Shanghai',
        country: 'China',
        date: '2026-03-15',
        time: '07:00:00Z',
        sprint: true,
      );
      final vegas = _race(
        round: '21',
        name: 'Las Vegas Grand Prix',
        circuitId: 'vegas',
        circuit: 'Las Vegas Strip Street Circuit',
        locality: 'Las Vegas',
        country: 'USA',
        date: '2026-11-22',
        time: '04:00:00Z',
      );
      final qatar = _race(
        round: '22',
        name: 'Qatar Grand Prix',
        circuitId: 'losail',
        circuit: 'Lusail International Circuit',
        locality: 'Lusail',
        country: 'Qatar',
        date: '2026-11-29',
        time: '16:00:00Z',
      );

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(brightness),
          home: Scaffold(
            appBar: AppBar(title: const Text('2026 赛历'), toolbarHeight: 56),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: NextRaceCard(race: vegas, now: now),
                ),
                const SectionHeader(
                  label: '整季赛历',
                  padding: EdgeInsets.fromLTRB(20, 26, 20, 10),
                  trailing: Text('24 站 · 6 场冲刺'),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 4),
                  child: Text('3月'),
                ),
                RaceListTile(race: china, isFinished: true, onTap: () {}),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 14, 20, 4),
                  child: Text('11月'),
                ),
                RaceListTile(race: vegas, isFinished: false, onTap: () {}),
                RaceListTile(race: qatar, isFinished: false, onTap: () {}),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: Icon(Icons.calendar_month_outlined),
                  selectedIcon: Icon(Icons.calendar_month),
                  label: '赛历',
                ),
                NavigationDestination(
                  icon: Icon(Icons.leaderboard_outlined),
                  selectedIcon: Icon(Icons.leaderboard),
                  label: '积分',
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../docs/assets/preview-${brightness.name}.png'),
      );
    });
  }
}
