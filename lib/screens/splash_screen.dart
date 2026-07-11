import 'package:flutter/material.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/layout/app_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<double> _progressOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeIn),
      ),
    );
    _progressOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Auto navigate after animation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AppShell(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF090B12),
              Color(0xFF0F1520),
              Color(0xFF151923),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated gradient overlay
            Positioned.fill(
              child: _AnimatedGradientBackground(
                controller: _controller,
              ),
            ),
            // Content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoOpacity.value,
                        child: Transform.scale(
                          scale: _logoScale.value,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF5B7FFF),
                                  Color(0xFF8A5CFF),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF5B7FFF)
                                      .withValues(alpha: 0.3),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              color: Colors.white,
                              size: 52,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Title
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textOpacity.value,
                        child: Column(
                          children: [
                            Text(
                              'Premium VPN',
                              style: TextStyle(
                                color: ThemeDefine.kTextPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'AI Network Accelerator',
                              style: TextStyle(
                                color: ThemeDefine.kTextSecondary,
                                fontSize: 16,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 48),
                  // Loading indicator
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _progressOpacity.value,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 160,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: LinearProgressIndicator(
                                  backgroundColor:
                                      Colors.white.withValues(alpha: 0.08),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF5B7FFF),
                                  ),
                                  minHeight: 3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'v1.0.27',
                              style: TextStyle(
                                color: ThemeDefine.kTextSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedGradientBackground extends StatelessWidget {
  final Animation<double> controller;

  const _AnimatedGradientBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return IgnorePointer(
          child: CustomPaint(
            painter: _SplashBackgroundPainter(phase: controller.value * 2),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}

class _SplashBackgroundPainter extends CustomPainter {
  final double phase;

  _SplashBackgroundPainter({required this.phase});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF5B7FFF).withValues(alpha: 0.03)
      ..style = PaintingStyle.fill;

    // Draw decorative circles
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      150 + phase * 20,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.8),
      100 - phase * 15,
      paint..color = const Color(0xFF8A5CFF).withValues(alpha: 0.03),
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      200 + phase * 30,
      paint..color = const Color(0xFF5B7FFF).withValues(alpha: 0.02),
    );
  }

  @override
  bool shouldRepaint(_SplashBackgroundPainter oldDelegate) =>
      oldDelegate.phase != phase;
}
