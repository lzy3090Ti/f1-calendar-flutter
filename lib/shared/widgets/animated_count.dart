import 'package:flutter/material.dart';

/// 积分数字滚动：首次挂载从 0 滚到目标值，数值变化时从当前值继续滚动。
class AnimatedCount extends StatefulWidget {
  const AnimatedCount({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 700),
    this.suffix = '',
  });

  final double value;
  final TextStyle? style;
  final Duration duration;
  final String suffix;

  @override
  State<AnimatedCount> createState() => _AnimatedCountState();
}

class _AnimatedCountState extends State<AnimatedCount>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      final from = _animation.value;
      _animation = Tween<double>(begin: from, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Text(
          '${_format(_animation.value)}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }

  String _format(double value) {
    final rounded = value.roundToDouble();
    if ((value - rounded).abs() < 0.001) return rounded.toInt().toString();
    return value.toStringAsFixed(1);
  }
}