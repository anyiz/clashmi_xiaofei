import 'package:flutter/material.dart';
import 'package:clashmi/screens/theme_define.dart';

class BreathingGlow extends StatefulWidget {
  final Widget child;
  final Color? color;
  final double blurRadius;
  final double spreadRadius;

  const BreathingGlow({
    super.key,
    required this.child,
    this.color,
    this.blurRadius = 30,
    this.spreadRadius = 10,
  });

  @override
  State<BreathingGlow> createState() => _BreathingGlowState();
}

class _BreathingGlowState extends State<BreathingGlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: (widget.color ?? ThemeDefine.kPrimary)
                    .withValues(alpha: _opacityAnimation.value),
                blurRadius: widget.blurRadius,
                spreadRadius: widget.spreadRadius *
                    (_opacityAnimation.value - 0.2),
              ),
            ],
          ),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
