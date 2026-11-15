import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/utils/date_x.dart';
import '../../../shared/models/locale_labels.dart';
import '../domain/race.dart';

/// 「下一场比赛」大卡片：城市 + 日期 + 天/时/分倒计时 + 赛道名。
/// 背景用对应国家的低饱和渐变，是整屏唯一的「重色块」。
class NextRaceCard extends StatelessWidget {
  const NextRaceCard({
    super.key,
    required this.race,
    required this.now,
  });

  final Race race;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final textTheme = Theme.of(context).textTheme;
    final gradient = raceGradient(race, dark: context.isDark);
    final countdown = CountdownParts.fromDuration(countdownTo(race, now));
    final start = race.startsAtLocal;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette.cardShadow,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: palette.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '下一场',
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ROUND ${race.round}',
                style: textTheme.labelMedium?.copyWith(color: palette.textSecondary),
              ),
              const Spacer(),
              Text(
                countryZh(race.country),
                style: textTheme.labelSmall?.copyWith(color: palette.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            raceTitleZh(race),
            style: textTheme.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              Icon(Icons.place_outlined, size: 14, color: palette.textSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${shortCircuitName(race.circuit.circuitName)} · ${localityZh(race.locality)}',
                  style: textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              _CountdownCell(value: '${countdown.days}', label: '天'),
              _Divider(color: palette.textTertiary.withValues(alpha: 0.35)),
              _CountdownCell(value: '${countdown.hours}', label: '时'),
              _Divider(color: palette.textTertiary.withValues(alpha: 0.35)),
              _CountdownCell(value: '${countdown.minutes}', label: '分'),
              const Spacer(),
              Text(
                '${formatMonthDay(start)}\n${formatClock(start)} 发车',
                textAlign: TextAlign.right,
                style: textTheme.labelSmall?.copyWith(height: 1.6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownCell extends StatelessWidget {
  const _CountdownCell({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value.padLeft(2, '0'),
          style: textTheme.displaySmall,
        ),
        const SizedBox(height: 2),
        Text(label, style: textTheme.labelSmall?.copyWith(color: palette.textSecondary)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      color: color,
    );
  }
}