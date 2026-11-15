import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// 分组标题：左侧 20 号标题，右侧一条极淡分割线收尾。
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    this.trailing,
    this.padding = const EdgeInsets.fromLTRB(20, 24, 20, 8),
  });

  final String label;
  final Widget? trailing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Text(label, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(width: 12),
          if (trailing == null)
            Expanded(
              child: Divider(
                height: 1,
                thickness: 1,
                color: palette.divider,
              ),
            )
          else
            const Spacer(),
          ?trailing,
        ],
      ),
    );
  }
}