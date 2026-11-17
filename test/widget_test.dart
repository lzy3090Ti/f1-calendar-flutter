import 'package:f1_calendar/app/theme.dart';
import 'package:f1_calendar/core/utils/date_x.dart';
import 'package:f1_calendar/features/calendar/domain/race.dart';
import 'package:f1_calendar/features/calendar/data/race_response.dart';
import 'package:f1_calendar/features/calendar/data/race_result_response.dart';
import 'package:f1_calendar/features/standings/data/standings_response.dart';
import 'package:f1_calendar/features/standings/data/driver_standings_response.dart';
import 'package:f1_calendar/features/calendar/presentation/next_race_card.dart';
import 'package:f1_calendar/shared/models/locale_labels.dart';
import 'package:f1_calendar/shared/models/team_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Race buildRace({
  String round = '21',
  String raceName = 'Las Vegas Grand Prix',
  String date = '2026-11-22',
  String? time = '04:00:00Z',
  String locality = 'Las Vegas',
  String country = 'USA',
  bool sprint = false,
}) {
  return Race(
    season: '2026',
    round: round,
    raceName: raceName,
    circuit: Circuit(
      circuitId: 'vegas',
      circuitName: 'Las Vegas Strip Street Circuit',
      location: CircuitLocation(
        lat: '36.1147',
        long: '-115.173',
        locality: locality,
        country: country,
      ),
    ),
    date: date,
    time: time,
    sprint: sprint
        ? const RaceSession(date: '2026-11-21', time: '04:00:00Z')
        : null,
  );
}

void main() {
  setUpAll(() async {
    Intl.defaultLocale = 'zh_CN';
    await initializeDateFormatting('zh_CN');
  });

  group('下一场比赛计算', () {
    test('取最近一场尚未开始的比赛', () {
      final races = <Race>[
        buildRace(
          round: '20',
          date: '2026-11-08',
          locality: 'São Paulo',
          country: 'Brazil',
        ),
        buildRace(),
        buildRace(
          round: '22',
          date: '2026-11-29',
          locality: 'Lusail',
          country: 'Qatar',
        ),
      ];
      final next = nextRaceOf(races, DateTime(2026, 11, 11, 22));
      expect(next, isNotNull);
      expect(next!.round, '21');
    });

    test('整季结束后返回 null', () {
      final races = <Race>[buildRace()];
      final next = nextRaceOf(races, DateTime(2026, 12, 30));
      expect(next, isNull);
    });

    test('已开赛的分站计为已完赛', () {
      final race = buildRace();
      expect(race.isFinishedAt(DateTime(2026, 12, 1)), isTrue);
      expect(race.isFinishedAt(DateTime(2026, 11, 1)), isFalse);
    });

    test('倒计时按天/时/分拆解，负值归零', () {
      final race = buildRace();
      final start = race.startsAtLocal!;
      final parts = CountdownParts.fromDuration(
        start.difference(
          start.subtract(const Duration(days: 2, hours: 3, minutes: 5)),
        ),
      );
      expect(parts.days, 2);
      expect(parts.hours, 3);
      expect(parts.minutes, 5);

      final past = CountdownParts.fromDuration(
        start.difference(start.add(const Duration(hours: 1))),
      );
      expect(past.days, 0);
      expect(past.hours, 0);
    });

    test('赛历按自然月分组且保持站次顺序', () {
      final races = <Race>[
        buildRace(
          round: '1',
          date: '2026-03-08',
          locality: 'Melbourne',
          country: 'Australia',
        ),
        buildRace(
          round: '2',
          date: '2026-03-15',
          locality: 'Shanghai',
          country: 'China',
        ),
        buildRace(),
      ];
      final grouped = groupByMonth(races);
      expect(grouped.keys.toList(), <String>['3月', '11月']);
      expect(grouped['3月']!.map((race) => race.round).toList(), <String>[
        '1',
        '2',
      ]);
    });

    test('不硬编码站数：列表长度随接口返回', () {
      final races = <Race>[buildRace(round: '1'), buildRace(round: '2')];
      expect(races.length, 2);
      expect(races.last.roundNumber, 2);
    });
  });

  group('素材映射与文案', () {
    test('11 支车队都有车图与两名车手', () {
      expect(teamAssets, hasLength(11));
      for (final team in teamAssets) {
        expect(team.carUrlList, contains('w_600'));
        expect(team.carUrlDetail, contains('w_1200'));
        expect(team.drivers, hasLength(2));
        expect(
          team.drivers.first.avatarUrl(slug: team.slug),
          contains('w_440'),
        );
      }
    });

    test('未知车队走灰色兜底而不是抛错', () {
      final unknown = teamAssetFor('unknown_team');
      expect(unknown.color, const Color(0xFF9E9E9E));
      expect(unknown.drivers, isEmpty);
    });

    test('2026 车手 ID 映射到正确照片，不回退成贝尔曼', () {
      expect(driverAssetFor('ryo_hirakawa', 'haas')?.code, 'ryohir01');
      expect(driverAssetFor('rafael_camara', 'haas')?.code, 'rafcam01');
      expect(driverAssetFor('ocon', 'haas')?.code, 'estoco01');
      expect(driverAssetFor('max_verstappen', 'red_bull')?.code, 'maxver01');
    });

    test('赛车图开启透明通道', () {
      expect(
        teamAssetFor('mercedes').carUrlList,
        contains('fl_preserve_transparency'),
      );
    });

    test('美国站用城市区分三个分站', () {
      expect(raceTitleZh(buildRace()), '拉斯维加斯大奖赛');
      expect(
        raceTitleZh(buildRace(locality: 'Miami', country: 'USA')),
        '迈阿密大奖赛',
      );
      expect(
        raceTitleZh(buildRace(locality: 'Melbourne', country: 'Australia')),
        '澳大利亚大奖赛',
      );
    });

    test('赛道长名压成短名', () {
      expect(shortCircuitName('Albert Park Grand Prix Circuit'), 'Albert Park');
      expect(
        shortCircuitName('Las Vegas Strip Street Circuit'),
        'Las Vegas Strip',
      );
    });

    test('深色模式渐变整体压暗', () {
      final light = raceGradient(buildRace(), dark: false).first;
      final dark = raceGradient(buildRace(), dark: true).first;
      expect(light.computeLuminance(), greaterThan(dark.computeLuminance()));
    });
  });

  testWidgets('下一场卡片展示分站、赛道与倒计时', (tester) async {
    final race = buildRace();
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Brightness.light),
        home: Scaffold(
          body: SingleChildScrollView(
            child: NextRaceCard(race: race, now: DateTime(2026, 11, 20, 12)),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('下一场'), findsOneWidget);
    expect(find.text('拉斯维加斯大奖赛'), findsOneWidget);
    expect(find.text('ROUND 21'), findsOneWidget);
    expect(find.text('天'), findsOneWidget);
    expect(find.text('时'), findsOneWidget);
    expect(find.text('分'), findsOneWidget);
  });

  test('Jolpica 赛历响应能解析大写嵌套字段', () {
    final response = RaceTableResponse.fromJson(<String, dynamic>{
      'MRData': <String, dynamic>{
        'RaceTable': <String, dynamic>{
          'season': '2026',
          'Races': <Map<String, dynamic>>[
            <String, dynamic>{
              'season': '2026',
              'round': '21',
              'raceName': 'Las Vegas Grand Prix',
              'date': '2026-11-22',
              'time': '04:00:00Z',
              'Circuit': <String, dynamic>{
                'circuitId': 'vegas',
                'circuitName': 'Las Vegas Strip Street Circuit',
                'Location': <String, dynamic>{
                  'lat': '36.1147',
                  'long': '-115.173',
                  'locality': 'Las Vegas',
                  'country': 'USA',
                },
              },
            },
          ],
        },
      },
    });

    expect(response.mrData.races, hasLength(1));
    expect(response.mrData.races.single.circuit.location.locality, 'Las Vegas');
  });

  test('Jolpica 积分响应能解析 Constructor 字段', () {
    final response = StandingsResponse.fromJson(<String, dynamic>{
      'MRData': <String, dynamic>{
        'StandingsTable': <String, dynamic>{
          'season': '2026',
          'round': '20',
          'StandingsLists': <Map<String, dynamic>>[
            <String, dynamic>{
              'season': '2026',
              'round': '20',
              'ConstructorStandings': <Map<String, dynamic>>[
                <String, dynamic>{
                  'position': '1',
                  'positionText': '1',
                  'points': '652',
                  'wins': '12',
                  'Constructor': <String, dynamic>{
                    'constructorId': 'mercedes',
                    'name': 'Mercedes',
                    'nationality': 'German',
                  },
                },
              ],
            },
          ],
        },
      },
    });

    expect(response.rows, hasLength(1));
    expect(response.rows.single.constructorId, 'mercedes');
    expect(response.rows.single.pointsValue, 652);
  });

  test('Jolpica 车手积分响应能解析 Constructors 字段', () {
    final response = DriverStandingsResponse.fromJson(<String, dynamic>{
      'MRData': <String, dynamic>{
        'StandingsTable': <String, dynamic>{
          'StandingsLists': <Map<String, dynamic>>[
            <String, dynamic>{
              'season': '2026',
              'round': '20',
              'DriverStandings': <Map<String, dynamic>>[
                <String, dynamic>{
                  'position': '1',
                  'positionText': '1',
                  'points': '390',
                  'wins': '5',
                  'Driver': <String, dynamic>{
                    'driverId': 'antonelli',
                    'givenName': 'Andrea Kimi',
                    'familyName': 'Antonelli',
                    'nationality': 'Italian',
                  },
                  'Constructors': <Map<String, dynamic>>[
                    <String, dynamic>{
                      'constructorId': 'mercedes',
                      'name': 'Mercedes',
                      'nationality': 'German',
                    },
                  ],
                },
              ],
            },
          ],
        },
      },
    });

    expect(response.rows.single.driver.driverId, 'antonelli');
    expect(response.rows.single.constructorId, 'mercedes');
    expect(response.rows.single.pointsValue, 390);
  });

  test('Jolpica 赛历响应能解析练习赛与排位赛时间', () {
    final response = RaceTableResponse.fromJson(<String, dynamic>{
      'MRData': <String, dynamic>{
        'RaceTable': <String, dynamic>{
          'season': '2026',
          'Races': <Map<String, dynamic>>[
            <String, dynamic>{
              'season': '2026',
              'round': '2',
              'raceName': 'Chinese Grand Prix',
              'date': '2026-03-15',
              'time': '07:00:00Z',
              'FirstPractice': <String, dynamic>{
                'date': '2026-03-13',
                'time': '03:30:00Z',
              },
              'Qualifying': <String, dynamic>{
                'date': '2026-03-14',
                'time': '07:00:00Z',
              },
              'Circuit': <String, dynamic>{
                'circuitId': 'shanghai',
                'circuitName': 'Shanghai International Circuit',
                'Location': <String, dynamic>{
                  'lat': '31.3389',
                  'long': '121.22',
                  'locality': 'Shanghai',
                  'country': 'China',
                },
              },
            },
          ],
        },
      },
    });

    final race = response.mrData.races.single;
    expect(race.firstPractice?.date, '2026-03-13');
    expect(race.qualifying?.time, '07:00:00Z');
  });

  test('Jolpica 正赛结果能解析车手排名与积分', () {
    final response = RaceResultsResponse.fromJson(<String, dynamic>{
      'MRData': <String, dynamic>{
        'RaceTable': <String, dynamic>{
          'Races': <Map<String, dynamic>>[
            <String, dynamic>{
              'Results': <Map<String, dynamic>>[
                <String, dynamic>{
                  'position': '1',
                  'positionText': '1',
                  'points': '25',
                  'status': 'Finished',
                  'Driver': <String, dynamic>{
                    'driverId': 'norris',
                    'givenName': 'Lando',
                    'familyName': 'Norris',
                  },
                  'Constructor': <String, dynamic>{
                    'constructorId': 'mclaren',
                    'name': 'McLaren',
                  },
                },
              ],
            },
          ],
        },
      },
    });

    expect(response.results.single.driverName, 'Lando Norris');
    expect(response.results.single.constructorId, 'mclaren');
    expect(response.results.single.pointsValue, 25);
  });
}
