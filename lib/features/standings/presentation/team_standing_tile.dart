import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../shared/models/team_asset.dart';
import '../../../shared/widgets/animated_count.dart';
import '../../../shared/widgets/car_image.dart';
import '../domain/standing.dart';

/// 车队积分海报卡，赛车保持 contain，避免图片被裁成中央一截。
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
    final team = teamAssetFor(standing.constructorId);
    final palette = context.palette;
    final start = Color.lerp(team.color, palette.canvas, 0.55)!;
    final end = Color.lerp(team.color, const Color(0xFF11131A), 0.8)!;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 168,
              child: Stack(
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[start, end],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const SizedBox.expand(),
                  ),
                  Positioned(
                    right: 18,
                    top: 6,
                    child: Text(
                      standing.positionText,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.17),
                        fontSize: 132,
                        height: 0.9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    top: 17,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              team.nameZh,
                              style: textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              team.name,
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.84),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 106,
                    bottom: 8,
                    height: 70,
                    child: CarImage(
                      team: team,
                      width: 720,
                      memCacheWidth: 720,
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 17,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AnimatedCount(
                          value: standing.pointsValue,
                          style: textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            'PTS',
                            style: textTheme.labelSmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 17,
                    top: 15,
                    child: Text(
                      '#${standing.positionText}',
                      style: textTheme.labelMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
