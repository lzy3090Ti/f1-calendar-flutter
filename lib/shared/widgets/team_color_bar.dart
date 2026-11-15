import 'package:flutter/material.dart';

/// 车队色竖条：4px 宽，圆角，作为积分榜行的视觉锚点。
class TeamColorBar extends StatelessWidget {
  const TeamColorBar({
    super.key,
    required this.color,
    this.width = 4,
    this.height = 36,
    this.radius = 2,
  });

  final Color color;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}