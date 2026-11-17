import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../shared/models/team_asset.dart';
import '../../../shared/widgets/animated_count.dart';
import '../domain/driver_standing.dart';

/// 参考赛季海报的车手积分卡：车队色渐变、排名水印、完整半身照片与大积分。
class DriverStandingTile extends StatelessWidget {
  const DriverStandingTile({super.key, required this.standing});

  final DriverStanding standing;

  @override
  Widget build(BuildContext context) {
    final team = teamAssetFor(standing.constructorId);
    final driver = driverAssetFor(
      standing.driver.driverId,
      standing.constructorId,
    );
    final textTheme = Theme.of(context).textTheme;
    final palette = context.palette;
    final start = Color.lerp(team.color, palette.canvas, 0.58)!;
    final end = Color.lerp(team.color, const Color(0xFF11131A), 0.78)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: SizedBox(
              height: 172,
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
                    right: 122,
                    bottom: -36,
                    child: Text(
                      standing.positionText,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.18),
                        fontSize: 136,
                        height: 0.9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    top: 18,
                    right: 128,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 4,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                driver?.nameZh ?? standing.driver.fullName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                standing.driver.fullName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.labelSmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.72),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                team.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.82),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 15,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AnimatedCount(
                          value: standing.pointsValue,
                          style: textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            'PTS',
                            style: textTheme.labelMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.92),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (driver != null)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      width: 154,
                      height: 178,
                      child: CachedNetworkImage(
                        imageUrl: driver.avatarUrl(slug: team.slug, width: 520),
                        memCacheWidth: 520,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                        errorWidget: (context, url, error) => Icon(
                          Icons.person_outline,
                          color: Colors.white.withValues(alpha: 0.7),
                          size: 56,
                        ),
                      ),
                    ),
                  Positioned(
                    right: 16,
                    top: 15,
                    child: Text(
                      '#${standing.positionText}',
                      style: textTheme.labelMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.88),
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
