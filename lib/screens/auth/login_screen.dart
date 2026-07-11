import 'dart:math';
import 'package:flutter/material.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/layout/app_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    setState(() => _isLoading = true);
    // Simulate login
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AppShell()),
      );
    });
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
        child: SafeArea(
          child: Center(
            child: PlatformUtils.isPC()
                ? _buildDesktopLayout()
                : _buildMobileLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignSystem.kSpace32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Left illustration
          Container(
            width: 360,
            padding: const EdgeInsets.all(DesignSystem.kSpace32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLogo(64),
                const SizedBox(height: 24),
                Text(
                  'Premium VPN',
                  style: TextStyle(
                    color: ThemeDefine.kTextPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '安全 · 快速 · 稳定',
                  style: TextStyle(
                    color: ThemeDefine.kTextSecondary,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 48),
                // Decorative circles
                CustomPaint(
                  size: const Size(200, 200),
                  painter: _LoginDecorationPainter(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          // Right form
          _buildLoginCard(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignSystem.kSpace24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 48),
          _buildLogo(56),
          const SizedBox(height: 16),
          Text(
            'Premium VPN',
            style: TextStyle(
              color: ThemeDefine.kTextPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          _buildLoginCard(),
        ],
      ),
    );
  }

  Widget _buildLogo(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B7FFF), Color(0xFF8A5CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B7FFF).withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        Icons.shield_outlined,
        color: Colors.white,
        size: size * 0.5,
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(DesignSystem.kSpace32),
      decoration: BoxDecoration(
        color: ThemeDefine.kGlassDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '欢迎回来',
            style: TextStyle(
              color: ThemeDefine.kTextPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '登录您的账号以继续',
            style: TextStyle(
              color: ThemeDefine.kTextSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 28),
          // Email field
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: '邮箱/手机号',
              prefixIcon: Icon(
                Icons.email_outlined,
                color: ThemeDefine.kTextSecondary,
                size: 20,
              ),
            ),
            style: TextStyle(color: ThemeDefine.kTextPrimary),
          ),
          const SizedBox(height: 16),
          // Password field
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: '密码',
              prefixIcon: Icon(
                Icons.lock_outlined,
                color: ThemeDefine.kTextSecondary,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: ThemeDefine.kTextSecondary,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            style: TextStyle(color: ThemeDefine.kTextPrimary),
          ),
          const SizedBox(height: 24),
          // Login button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF5B7FFF), Color(0xFF8A5CFF)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      )
                    : Text(
                        '登录',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.95),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Register & Forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '注册账号',
                  style: TextStyle(color: ThemeDefine.kPrimary),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '忘记密码?',
                  style: TextStyle(color: ThemeDefine.kTextSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Social login
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '社交登录',
                  style: TextStyle(
                    color: ThemeDefine.kTextSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(Icons.g_mobiledata, 'Google'),
              const SizedBox(width: 16),
              _buildSocialButton(Icons.apple, 'Apple'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: ThemeDefine.kTextPrimary,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class _LoginDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Outer ring
    final ringPaint = Paint()
      ..color = const Color(0xFF5B7FFF).withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, 80, ringPaint);
    canvas.drawCircle(center, 60, ringPaint);
    canvas.drawCircle(center, 40, ringPaint);

    // Center dot
    canvas.drawCircle(
      center,
      4,
      Paint()..color = const Color(0xFF5B7FFF).withValues(alpha: 0.3),
    );

    // Orbital dots
    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * 3.14159 * 2;
      final x = center.dx + cos(angle) * 70;
      final y = center.dy + sin(angle) * 70;
      canvas.drawCircle(
        Offset(x, y),
        2,
        Paint()
          ..color = const Color(0xFF8A5CFF).withValues(alpha: 0.2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
