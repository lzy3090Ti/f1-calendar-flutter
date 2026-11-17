import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/error/failure.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_view.dart';
import '../domain/driver_standing.dart';
import '../domain/standing.dart';
import 'driver_standing_tile.dart';
import 'standings_providers.dart';
import 'team_standing_tile.dart';

/// 积分榜采用参考图的海报式信息层级：先看车手积分，再切换车队积分。
class StandingsPage extends ConsumerWidget {
  const StandingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(seasonProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '$season 积分榜',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: 56,
          actions: <Widget>[
            IconButton(
              tooltip: '主屏小组件',
              onPressed: () => context.push('/standings/widgets'),
              icon: const Icon(Icons.widgets_outlined),
            ),
          ],
          bottom: TabBar(
            tabs: const <Widget>[
              Tab(text: '车手'),
              Tab(text: '车队'),
            ],
            labelColor: context.palette.accent,
            unselectedLabelColor: context.palette.textTertiary,
            indicatorColor: context.palette.accent,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[_DriverStandingsView(), _TeamStandingsView()],
        ),
      ),
    );
  }
}

class _DriverStandingsView extends ConsumerWidget {
  const _DriverStandingsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRows = ref.watch(driverStandingsProvider);
    return RefreshIndicator(
      color: context.palette.accent,
      onRefresh: () => ref.read(driverStandingsProvider.notifier).refresh(),
      child: asyncRows.when(
        loading: () => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const <Widget>[
            SizedBox(height: 200),
            LoadingView(message: '正在获取车手积分'),
          ],
        ),
        error: (error, _) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 160),
            ErrorView(
              message: error is Failure ? error.message : '车手积分加载失败',
              onRetry: () => ref.invalidate(driverStandingsProvider),
            ),
          ],
        ),
        data: (rows) => _DriverStandingsContent(rows: rows),
      ),
    );
  }
}

class _DriverStandingsContent extends StatelessWidget {
  const _DriverStandingsContent({required this.rows});

  final List<DriverStanding> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const _EmptyStandings(message: '车手积分榜尚未产生');
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        SectionHeader(
          label: '车手积分榜',
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
          trailing: Text(
            '${rows.length} 位车手',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        for (final row in rows) DriverStandingTile(standing: row),
      ],
    );
  }
}

class _TeamStandingsView extends ConsumerWidget {
  const _TeamStandingsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRows = ref.watch(standingsProvider);
    return RefreshIndicator(
      color: context.palette.accent,
      onRefresh: () => ref.read(standingsProvider.notifier).refresh(),
      child: asyncRows.when(
        loading: () => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const <Widget>[
            SizedBox(height: 200),
            LoadingView(message: '正在获取车队积分'),
          ],
        ),
        error: (error, _) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 160),
            ErrorView(
              message: error is Failure ? error.message : '车队积分加载失败',
              onRetry: () => ref.invalidate(standingsProvider),
            ),
          ],
        ),
        data: (rows) => _TeamStandingsContent(rows: rows),
      ),
    );
  }
}

class _TeamStandingsContent extends StatelessWidget {
  const _TeamStandingsContent({required this.rows});

  final List<ConstructorStanding> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const _EmptyStandings(message: '车队积分榜尚未产生');
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        SectionHeader(
          label: '车队积分榜',
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
          trailing: Text(
            '${rows.length} 支车队',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        for (final row in rows)
          TeamStandingTile(
            standing: row,
            onTap: () => context.push('/standings/team/${row.constructorId}'),
          ),
      ],
    );
  }
}

class _EmptyStandings extends StatelessWidget {
  const _EmptyStandings({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    children: <Widget>[
      const SizedBox(height: 180),
      Center(
        child: Text(message, style: Theme.of(context).textTheme.bodySmall),
      ),
    ],
  );
}
