import 'package:flutter/material.dart';
import 'package:clashmi/screens/language_settings_screen.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/widgets/glass_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人中心'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignSystem.kSpace16),
        child: Column(
          children: [
            // User info card
            GlassCard(
              padding: EdgeInsets.all(DesignSystem.kSpace24),
              child: Column(
                children: [
                  // Avatar
                  Stack(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF5B7FFF),
                              Color(0xFF8A5CFF),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: DesignSystem.kSpace6,
                            vertical: DesignSystem.kSpace2,
                          ),
                          decoration: BoxDecoration(
                            color: ThemeDefine.kPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'VIP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: DesignSystem.kSpace12),
                  Text(
                    '用户名',
                    style: TextStyle(
                      color: ThemeDefine.kTextPrimary,
                      fontSize: DesignSystem.kTextXl,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: DesignSystem.kSpace4),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: ThemeDefine.kTextSecondary,
                      fontSize: DesignSystem.kTextSm,
                    ),
                  ),
                  SizedBox(height: DesignSystem.kSpace12),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DesignSystem.kSpace12,
                      vertical: DesignSystem.kSpace4,
                    ),
                    decoration: BoxDecoration(
                      color: ThemeDefine.kPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Premium 会员',
                      style: TextStyle(
                        color: ThemeDefine.kPrimary,
                        fontSize: DesignSystem.kTextSm,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace24),

            // Settings list
            GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildMenuItem(Icons.devices, '设备管理', '2台设备在线', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.notifications_outlined, '通知设置', null,
                      () {}),
                  _buildDivider(),
                  _buildMenuItem(
                      Icons.palette_outlined, '外观设置', '深色模式', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.language, '语言', '简体中文', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LanguageSettingsScreen(
                          canPop: true,
                          canGoBack: true,
                        ),
                      ),
                    );
                  }),
                  _buildDivider(),
                  _buildMenuItem(
                      Icons.headset_mic_outlined, '客服支持', null, () {}),
                  _buildDivider(),
                  _buildMenuItem(
                      Icons.feedback_outlined, '意见反馈', null, () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.info_outline, '关于', null, () {}),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace24),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: ThemeDefine.kError,
                  side: BorderSide(color: ThemeDefine.kError.withValues(alpha: 0.3)),
                  padding: EdgeInsets.symmetric(vertical: DesignSystem.kSpace12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DesignSystem.kRadiusStandard),
                  ),
                ),
                child: const Text('退出登录'),
              ),
            ),
            SizedBox(height: DesignSystem.kSpace32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String? subtitle,
      VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: ThemeDefine.kTextSecondary),
      title: Text(
        title,
        style: TextStyle(
          color: ThemeDefine.kTextPrimary,
          fontSize: DesignSystem.kTextBase,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                color: ThemeDefine.kTextSecondary,
                fontSize: DesignSystem.kTextSm,
              ),
            ),
          SizedBox(width: DesignSystem.kSpace4),
          Icon(
            Icons.chevron_right,
            color: ThemeDefine.kTextSecondary,
            size: 20,
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: 56,
      color: Colors.white.withValues(alpha: 0.06),
    );
  }
}
