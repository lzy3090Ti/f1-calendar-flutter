import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/error/failure.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_view.dart';
import '../domain/standing.dart';
import 'standings_providers.dart';
import 'team_standing_tile.dart';

class StandingsPage extends ConsumerWidget {
  const StandingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(seasonProvider);
    final asyncStandings = ref.watch(standingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('$season 积分榜', style: Theme.of(context).textTheme.titleLarge),
        toolbarHeight: 56,
      ),
      body: RefreshIndicator(
        color: context.palette.accent,
        onRefresh: () => _refresh(context, ref),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: asyncStandings.when(
            loading: () => ListView(
              key: const ValueKey<String>('loading'),
              physics: const AlwaysScrollableScrollPhysics(),
              children: const <Widget>[
                SizedBox(height: 200),
                LoadingView(message: '正在获取积分榜'),
              ],
            ),
            error: (error, _) => ListView(
              key: const ValueKey<String>('error'),
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                const SizedBox(height: 160),
                ErrorView(
                  message: error is Failure ? error.message : '积分榜加载失败',
                  onRetry: () => ref.invalidate(standingsProvider),
                ),
              ],
            ),
            data: (rows) => _StandingsContent(
              key: const ValueKey<String>('data'),
              rows: rows,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(standingsProvider.notifier).refresh();
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
}

class _StandingsContent extends StatelessWidget {
  const _StandingsContent({super.key, required this.rows});

  final List<ConstructorStanding> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 160),
          Center(
            child: Text(
              '积分榜尚未产生',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        SectionHeader(
          label: '车队积分榜',
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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