import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../models/team_asset.dart';

/// 赛车图：官方素材是白底横幅，统一白底板 + contain，绝不裁切。
///
/// URL 里的 `w_` 决定远端尺寸，`memCacheWidth` 决定解码尺寸，两者配合省流量也省内存。
class CarImage extends StatelessWidget {
  const CarImage({
    super.key,
    required this.team,
    this.width = 600,
    this.height,
    this.memCacheWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
  });

  final TeamAsset team;

  /// 远端图片宽度（Cloudinary 变换参数 w_）。
  final int width;
  final double? height;

  /// 解码宽度，默认跟随远端宽度。
  final int? memCacheWidth;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CachedNetworkImage(
        imageUrl: team.carUrl(width: width),
        memCacheWidth: memCacheWidth ?? width,
        fit: BoxFit.contain,
        fadeInDuration: const Duration(milliseconds: 220),
        placeholder: (context, url) => const Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.directions_car_outlined,
          color: context.palette.textTertiary,
        ),
      ),
    );
  }
}

/// 车手头像：白底半身像，方形圆角。
class DriverAvatar extends StatelessWidget {
  const DriverAvatar({
    super.key,
    required this.driver,
    required this.teamSlug,
    this.size = 56,
    this.memCacheWidth,
  });

  final DriverAsset driver;
  final String teamSlug;
  final double size;
  final int? memCacheWidth;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: size,
        height: size,
        color: Colors.white,
        child: CachedNetworkImage(
          imageUrl: driver.avatarUrl(slug: teamSlug, width: 440),
          memCacheWidth: memCacheWidth ?? (size * 2).round(),
          fit: BoxFit.contain,
          fadeInDuration: const Duration(milliseconds: 200),
          placeholder: (context, url) => const Center(
            child: SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.person_outline,
            size: size * 0.5,
            color: context.palette.textTertiary,
          ),
        ),
      ),
    );
  }
}
