import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/error/failure.dart';
import '../../../core/utils/date_x.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_view.dart';
import '../domain/race.dart';
import 'calendar_providers.dart';
import 'next_race_card.dart';
import 'race_list_tile.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(seasonProvider);
    final asyncRaces = ref.watch(racesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$season 赛历',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: 56,
      ),
      body: RefreshIndicator(
        color: context.palette.accent,
        onRefresh: () => _refresh(context, ref),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _buildBody(context, ref, asyncRaces),
        ),
      ),
    );
  }

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(racesProvider.notifier).refresh();
    } on Failure catch (error) {
      if (context.mounted) _showMessage(context, error.message);
    } on Object {
      if (context.mounted) _showMessage(context, '刷新失败，请稍后重试');
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<Race>> asyncRaces,
  ) {
    return asyncRaces.when(
      loading: () => ListView(
        key: const ValueKey<String>('loading'),
        physics: const AlwaysScrollableScrollPhysics(),
        children: const <Widget>[
          SizedBox(height: 200),
          LoadingView(message: '正在获取赛历'),
        ],
      ),
      error: (error, _) => ListView(
        key: const ValueKey<String>('error'),
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 160),
          ErrorView(
            message: error is Failure ? error.message : '赛历加载失败',
            onRetry: () => ref.invalidate(racesProvider),
          ),
        ],
      ),
      data: (races) =>
          _CalendarContent(key: const ValueKey<String>('data'), races: races),
    );
  }
}

class _CalendarContent extends StatelessWidget {
  const _CalendarContent({super.key, required this.races});

  final List<Race> races;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final now = DateTime.now();

    if (races.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 160),
          Center(
            child: Text(
              '本赛季赛历尚未发布',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      );
    }

    final nextRace = nextRaceOf(races, now);
    final grouped = groupByMonth(races);
    final sprintCount = races.where((race) => race.isSprintWeekend).length;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: nextRace == null
              ? _SeasonOverCard(races: races)
              : _LiveCountdown(race: nextRace),
        ),
        SectionHeader(
          label: '整季赛历',
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 10),
          trailing: Text(
            '${races.length} 站 · $sprintCount 场冲刺',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        for (final entry in grouped.entries) ...<Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
            child: Text(
              entry.key,
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: palette.textSecondary),
            ),
          ),
          for (final race in entry.value)
            RaceListTile(
              race: race,
              isFinished: race.isFinishedAt(now),
              onTap: () =>
                  context.push('/calendar/race/${race.round}', extra: race),
            ),
        ],
      ],
    );
  }
}

/// 仅这一块按秒刷新，避免整页（含 20+ 行列表）每秒重建。
class _LiveCountdown extends StatefulWidget {
  const _LiveCountdown({required this.race});

  final Race race;

  @override
  State<_LiveCountdown> createState() => _LiveCountdownState();
}

class _LiveCountdownState extends State<_LiveCountdown> {
  late DateTime _now;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NextRaceCard(race: widget.race, now: _now);
  }
}

/// 整季跑完后的收尾卡片：不做空白页。
class _SeasonOverCard extends StatelessWidget {
  const _SeasonOverCard({required this.races});

  final List<Race> races;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: context.cardDecoration(),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: palette.accentSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.flag_outlined, color: palette.accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('本赛季已收官', style: textTheme.titleLarge),
                const SizedBox(height: 2),
                Text(
                  '共 ${races.length} 站，下一赛季赛历发布后自动更新',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
