import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/error/failure.dart';
import '../../../core/utils/date_x.dart';
import '../../../shared/models/locale_labels.dart';
import '../../../shared/models/team_asset.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_view.dart';
import '../domain/race.dart';
import '../domain/race_result.dart';
import 'calendar_providers.dart';

class RaceDetailPage extends ConsumerWidget {
  const RaceDetailPage({super.key, required this.race});

  final Race race;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finished = race.isFinishedAt(DateTime.now());
    final results = finished
        ? ref.watch(raceResultsProvider(race.round))
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(raceTitleZh(race)), toolbarHeight: 56),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: <Widget>[
          _RaceHeader(race: race),
          const SectionHeader(
            label: '周末时间',
            padding: EdgeInsets.fromLTRB(20, 26, 20, 10),
          ),
          _SessionList(race: race),
          if (finished) ...<Widget>[
            const SectionHeader(
              label: '正赛车手排名',
              padding: EdgeInsets.fromLTRB(20, 26, 20, 10),
            ),
            _ResultsBody(
              results: results!,
              onRetry: () => ref.invalidate(raceResultsProvider(race.round)),
            ),
          ],
        ],
      ),
    );
  }
}

class _RaceHeader extends StatelessWidget {
  const _RaceHeader({required this.race});

  final Race race;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        decoration: context.cardDecoration(),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'ROUND ${race.round}',
                  style: textTheme.labelMedium?.copyWith(color: palette.accent),
                ),
                const Spacer(),
                Text(countryZh(race.country), style: textTheme.labelSmall),
              ],
            ),
            const SizedBox(height: 10),
            Text(raceTitleZh(race), style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              '${localityZh(race.locality)} · ${shortCircuitName(race.circuit.circuitName)}',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionList extends StatelessWidget {
  const _SessionList({required this.race});

  final Race race;

  @override
  Widget build(BuildContext context) {
    final sessions = <({String label, RaceSession? session})>[
      (label: '练习赛 1', session: race.firstPractice),
      (label: '练习赛 2', session: race.secondPractice),
      (label: '练习赛 3', session: race.thirdPractice),
      (label: '排位赛', session: race.qualifying),
      (label: '冲刺排位', session: race.sprintQualifying),
      (label: '冲刺赛', session: race.sprint),
      (label: '正赛', session: RaceSession(date: race.date, time: race.time)),
    ].where((entry) => entry.session != null).toList(growable: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: context.cardDecoration(),
        child: Column(
          children: <Widget>[
            for (var index = 0; index < sessions.length; index++)
              _SessionRow(
                label: sessions[index].label,
                session: sessions[index].session!,
                showDivider: index < sessions.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({
    required this.label,
    required this.session,
    required this.showDivider,
  });

  final String label;
  final RaceSession session;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: showDivider
          ? BoxDecoration(
              border: Border(bottom: BorderSide(color: palette.divider)),
            )
          : null,
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: textTheme.bodyMedium)),
          Text(
            formatFullDateTime(session.startsAtLocal),
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ResultsBody extends StatelessWidget {
  const _ResultsBody({required this.results, required this.onRetry});

  final AsyncValue<List<RaceResult>> results;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return results.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: LoadingView(message: '正在获取车手结果'),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: ErrorView(
          message: error is Failure ? error.message : '车手结果加载失败',
          onRetry: onRetry,
        ),
      ),
      data: (rows) => rows.isEmpty
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text('暂无车手结果'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: context.cardDecoration(),
                child: Column(
                  children: <Widget>[
                    for (var index = 0; index < rows.length; index++)
                      _ResultRow(
                        result: rows[index],
                        showDivider: index < rows.length - 1,
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.result, required this.showDivider});

  final RaceResult result;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final palette = context.palette;
    final team = teamAssetFor(result.constructorId);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: showDivider
          ? BoxDecoration(
              border: Border(bottom: BorderSide(color: palette.divider)),
            )
          : null,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 28,
            child: Text(result.positionText, style: textTheme.titleMedium),
          ),
          Container(width: 4, height: 28, color: team.color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  result.driverName,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(result.constructorName, style: textTheme.labelSmall),
              ],
            ),
          ),
          Text(
            '${result.pointsValue % 1 == 0 ? result.pointsValue.toInt() : result.pointsValue} 分',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
