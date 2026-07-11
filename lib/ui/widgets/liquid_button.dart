import 'dart:math';
import 'package:flutter/material.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';

enum LiquidButtonState { disconnected, connecting, connected }

class LiquidConnectButton extends StatefulWidget {
  final LiquidButtonState state;
  final VoidCallback onTap;

  const LiquidConnectButton({
    super.key,
    this.state = LiquidButtonState.disconnected,
    required this.onTap,
  });

  @override
  State<LiquidConnectButton> createState() => _LiquidConnectButtonState();
}

class _LiquidConnectButtonState extends State<LiquidConnectButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
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
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: _buildShadows(),
            ),
            child: CustomPaint(
              painter: _LiquidButtonPainter(
                state: widget.state,
                phase: _controller.value * 2 * pi,
                isDark:
                    Theme.of(context).brightness == Brightness.dark,
              ),
              child: Center(
                child: _buildCenterContent(),
              ),
            ),
          );
        },
      ),
    );
  }

  List<BoxShadow> _buildShadows() {
    switch (widget.state) {
      case LiquidButtonState.disconnected:
        return [
          BoxShadow(
            color: ThemeDefine.kPrimary.withValues(alpha: 0.2),
            blurRadius: 20 * (_pulseAnimation.value - 0.8),
            spreadRadius: 5 * (_pulseAnimation.value - 0.8),
          ),
        ];
      case LiquidButtonState.connecting:
        return [
          BoxShadow(
            color: ThemeDefine.kWarning.withValues(alpha: 0.3),
            blurRadius: 25,
            spreadRadius: 8,
          ),
        ];
      case LiquidButtonState.connected:
        return [
          BoxShadow(
            color: ThemeDefine.kSuccess.withValues(alpha: 0.25),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ];
    }
  }

  Widget _buildCenterContent() {
    switch (widget.state) {
      case LiquidButtonState.disconnected:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.power_settings_new,
                size: 48, color: Colors.white.withValues(alpha: 0.9)),
            const SizedBox(height: 8),
            Text(
              '点按连接',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: DesignSystem.kTextBase,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case LiquidButtonState.connecting:
        return SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(
              Colors.white.withValues(alpha: 0.9),
            ),
          ),
        );
      case LiquidButtonState.connected:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check,
                size: 48, color: Colors.white.withValues(alpha: 0.9)),
            const SizedBox(height: 8),
            Text(
              '已连接',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: DesignSystem.kTextBase,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
    }
  }
}

class _LiquidButtonPainter extends CustomPainter {
  final LiquidButtonState state;
  final double phase;
  final bool isDark;

  _LiquidButtonPainter({
    required this.state,
    required this.phase,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Determine colors
    Color gradientStart;
    Color gradientEnd;

    switch (state) {
      case LiquidButtonState.disconnected:
        gradientStart = const Color(0xFF5B7FFF);
        gradientEnd = const Color(0xFF8A5CFF);
        break;
      case LiquidButtonState.connecting:
        gradientStart = const Color(0xFFFFB340);
        gradientEnd = const Color(0xFFFF8C00);
        break;
      case LiquidButtonState.connected:
        gradientStart = const Color(0xFF30D158);
        gradientEnd = const Color(0xFF00A84D);
        break;
    }

    // Draw base circle with gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = RadialGradient(
      colors: [gradientStart, gradientEnd],
      stops: const [0.0, 1.0],
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    // Draw liquid wave effect (when connected)
    if (state == LiquidButtonState.connected) {
      final wavePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.08)
        ..style = PaintingStyle.fill;

      final wavePath = Path();
      final waveHeight = size.height * 0.05;
      final waveLength = size.width * 0.8;

      wavePath.moveTo(0, size.height * 0.45);
      for (double x = 0; x <= size.width; x++) {
        final y = size.height * 0.45 +
            sin((x / waveLength * 2 * pi) + phase) * waveHeight +
            sin((x / (waveLength * 0.5) * 2 * pi) + phase * 1.5) *
                waveHeight *
                0.5;
        wavePath.lineTo(x, y);
      }
      wavePath.lineTo(size.width, size.height);
      wavePath.lineTo(0, size.height);
      wavePath.close();

      canvas.drawPath(wavePath, wavePaint);

      // Second wave
      final wavePaint2 = Paint()
        ..color = Colors.white.withValues(alpha: 0.05)
        ..style = PaintingStyle.fill;

      final wavePath2 = Path();
      wavePath2.moveTo(0, size.height * 0.5);
      for (double x = 0; x <= size.width; x++) {
        final y = size.height * 0.5 +
            sin((x / waveLength * 2 * pi) + phase + pi / 2) * waveHeight * 0.8;
        wavePath2.lineTo(x, y);
      }
      wavePath2.lineTo(size.width, size.height);
      wavePath2.lineTo(0, size.height);
      wavePath2.close();

      canvas.drawPath(wavePath2, wavePaint2);
    }

    // Draw the main circle
    canvas.drawCircle(center, radius, paint);

    // Draw inner glow
    final innerGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, innerGlow);

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius - 1, borderPaint);
  }

  @override
  bool shouldRepaint(_LiquidButtonPainter oldDelegate) {
    return oldDelegate.phase != phase || oldDelegate.state != state;
  }
}
