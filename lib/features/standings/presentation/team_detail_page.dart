import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../shared/models/team_asset.dart';
import '../../../shared/widgets/animated_count.dart';
import '../../../shared/widgets/car_image.dart';
import '../../../shared/widgets/section_header.dart';
import 'standings_providers.dart';

/// 车队详情：全幅车图 + 名次/积分/胜场 + 两名车手头像。
class TeamDetailPage extends ConsumerWidget {
  const TeamDetailPage({super.key, required this.constructorId});

  final String constructorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final team = teamAssetFor(constructorId);
    final standing = ref.watch(standingByTeamProvider(constructorId));
    final textTheme = Theme.of(context).textTheme;
    final palette = context.palette;

    return Scaffold(
      appBar: AppBar(
        title: Text(team.nameZh, style: textTheme.titleLarge),
        toolbarHeight: 56,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CarImage(
                team: team,
                width: 1200,
                memCacheWidth: 1000,
                height: 180,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: team.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(team.name, style: textTheme.bodyMedium),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              decoration: context.cardDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _StatCell(
                      label: '名次',
                      value: standing?.position ?? '—',
                    ),
                  ),
                  _StatDivider(color: palette.divider),
                  Expanded(
                    child: _StatCell(
                      label: '积分',
                      value: standing?.points ?? '—',
                      animated: standing?.pointsValue,
                    ),
                  ),
                  _StatDivider(color: palette.divider),
                  Expanded(
                    child: _StatCell(
                      label: '胜场',
                      value: standing?.wins ?? '—',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader(
            label: '车手',
            padding: EdgeInsets.fromLTRB(20, 26, 20, 10),
          ),
          if (team.drivers.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text('车手资料待补充', style: textTheme.bodySmall),
            )
          else
            for (final driver in team.drivers)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Container(
                  decoration: context.cardDecoration(),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      DriverAvatar(
                        driver: driver,
                        teamSlug: team.slug,
                        size: 56,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              driver.nameZh,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(driver.name, style: textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.label,
    required this.value,
    this.animated,
  });

  final String label;
  final String value;
  final double? animated;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        animated == null
            ? Text(value, style: textTheme.displaySmall)
            : AnimatedCount(value: animated!, style: textTheme.displaySmall),
        const SizedBox(height: 4),
        Text(label, style: textTheme.labelSmall),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36, color: color);
  }
}