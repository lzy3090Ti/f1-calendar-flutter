import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/utils/date_x.dart';
import '../../../shared/models/locale_labels.dart';
import '../domain/race.dart';

/// 赛历列表行：站次 + 分站名 + 城市/赛道 + 日期时间。
/// 已赛场次整体降级为辅助文字色，冲刺赛加小徽标。
class RaceListTile extends StatelessWidget {
  const RaceListTile({
    super.key,
    required this.race,
    required this.isFinished,
    required this.onTap,
  });

  final Race race;
  final bool isFinished;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final textTheme = Theme.of(context).textTheme;
    final start = race.startsAtLocal;
    final primaryColor = isFinished
        ? palette.textTertiary
        : palette.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: palette.divider, width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 30,
                child: Text(
                  race.round.padLeft(2, '0'),
                  style: textTheme.labelMedium?.copyWith(
                    color: isFinished ? palette.textTertiary : palette.accent,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            raceTitleZh(race),
                            style: textTheme.bodyMedium?.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (race.isSprintWeekend) ...<Widget>[
                          const SizedBox(width: 6),
                          _SprintBadge(dimmed: isFinished),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${localityZh(race.locality)} · ${shortCircuitName(race.circuit.circuitName)}',
                      style: textTheme.labelSmall?.copyWith(
                        color: isFinished
                            ? palette.textTertiary
                            : palette.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    formatMonthDay(start),
                    style: textTheme.bodyMedium?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isFinished ? '已完赛' : formatClock(start),
                    style: textTheme.labelSmall?.copyWith(
                      color: isFinished
                          ? palette.textTertiary
                          : palette.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SprintBadge extends StatelessWidget {
  const _SprintBadge({required this.dimmed});

  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: dimmed ? palette.divider : palette.accentSoft,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '冲刺',
        style: TextStyle(
          fontSize: 10,
          height: 1.3,
          fontWeight: FontWeight.w600,
          color: dimmed ? palette.textTertiary : palette.accent,
        ),
      ),
    );
  }
}
