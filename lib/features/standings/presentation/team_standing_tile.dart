import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../shared/models/team_asset.dart';
import '../../../shared/widgets/animated_count.dart';
import '../../../shared/widgets/car_image.dart';
import '../../../shared/widgets/team_color_bar.dart';
import '../domain/standing.dart';

/// 积分榜行：队色竖条 + 名次 + 队名 + 车图缩略 + 积分 + 名次变化箭头。
class TeamStandingTile extends StatelessWidget {
  const TeamStandingTile({
    super.key,
    required this.standing,
    required this.onTap,
  });

  final ConstructorStanding standing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final team = teamAssetFor(standing.constructorId);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            decoration: context.cardDecoration(),
            padding: const EdgeInsets.fromLTRB(12, 10, 14, 10),
            child: Row(
              children: <Widget>[
                TeamColorBar(color: team.color, height: 44),
                const SizedBox(width: 12),
                SizedBox(
                  width: 24,
                  child: Text(
                    standing.position,
                    style: textTheme.titleLarge?.copyWith(
                      fontFeatures: const <FontFeature>[
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        team.nameZh,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        team.name,
                        style: textTheme.labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CarImage(
                  team: team,
                  width: 240,
                  memCacheWidth: 240,
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    AnimatedCount(
                      value: standing.pointsValue,
                      style: textTheme.displaySmall,
                    ),
                    const SizedBox(height: 2),
                    _PositionChange(change: standing.positionChange),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PositionChange extends StatelessWidget {
  const _PositionChange({required this.change});

  final int change;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (change == 0) {
      return Text('—', style: textTheme.labelSmall);
    }
    final up = change > 0;
    final color = up ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          up ? Icons.arrow_upward : Icons.arrow_downward,
          size: 11,
          color: color,
        ),
        const SizedBox(width: 2),
        Text(
          '${change.abs()}',
          style: textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}