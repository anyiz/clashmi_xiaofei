import 'package:flutter/material.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/widgets/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoConnect = false;
  bool _launchAtStartup = false;
  bool _showAdvanced = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignSystem.kSpace16),
        child: Column(
          children: [
            // Basic toggles
            GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildSwitchTile(Icons.autorenew, '自动连接', _autoConnect,
                      (v) => setState(() => _autoConnect = v)),
                  _buildDivider(),
                  _buildSwitchTile(Icons.power_settings_new, '开机自启',
                      _launchAtStartup,
                      (v) => setState(() => _launchAtStartup = v)),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace16),

            // Theme
            GlassCard(
              padding: EdgeInsets.all(DesignSystem.kSpace16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '外观',
                    style: TextStyle(
                      color: ThemeDefine.kTextPrimary,
                      fontSize: DesignSystem.kTextLg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: DesignSystem.kSpace12),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'dark', label: Text('深色')),
                      ButtonSegment(value: 'system', label: Text('系统')),
                      ButtonSegment(value: 'light', label: Text('浅色')),
                    ],
                    selected: const {'system'},
                    onSelectionChanged: (_) {},
                    style: ButtonStyle(
                      shape: WidgetStateProperty.resolveWith((states) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace16),

            // Network settings
            GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(DesignSystem.kSpace16),
                    child: Text(
                      '网络',
                      style: TextStyle(
                        color: ThemeDefine.kTextPrimary,
                        fontSize: DesignSystem.kTextLg,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _buildSelectTile(
                      Icons.dns_outlined, 'DNS 模式', 'System DNS', () {}),
                  _buildDivider(),
                  _buildSelectTile(
                      Icons.settings_ethernet, 'TUN 模式', 'Mixed', () {}),
                  _buildDivider(),
                  _buildSelectTile(
                      Icons.alt_route, '代理模式', 'Rule', () {}),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace16),

            // Advanced settings (collapsible)
            GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  InkWell(
                    onTap: () =>
                        setState(() => _showAdvanced = !_showAdvanced),
                    child: Padding(
                      padding: EdgeInsets.all(DesignSystem.kSpace16),
                      child: Row(
                        children: [
                          Icon(
                            _showAdvanced
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: ThemeDefine.kTextSecondary,
                          ),
                          SizedBox(width: DesignSystem.kSpace8),
                          Text(
                            '高级设置',
                            style: TextStyle(
                              color: ThemeDefine.kTextPrimary,
                              fontSize: DesignSystem.kTextBase,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_showAdvanced) ...[
                    _buildDivider(),
                    _buildSelectTile(
                        Icons.article_outlined, '日志级别', 'Info', () {}),
                    _buildDivider(),
                    _buildSwitchTile(
                        Icons.language, 'IPv6', false, (_) {}),
                    _buildDivider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DesignSystem.kSpace16,
                        vertical: DesignSystem.kSpace12,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.router_outlined,
                              color: ThemeDefine.kTextSecondary),
                          SizedBox(width: DesignSystem.kSpace12),
                          Text(
                            'Mixed Port',
                            style: TextStyle(
                              color: ThemeDefine.kTextPrimary,
                              fontSize: DesignSystem.kTextBase,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: DesignSystem.kSpace12,
                              vertical: DesignSystem.kSpace4,
                            ),
                            decoration: BoxDecoration(
                              color: ThemeDefine.kGlassDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '7890',
                              style: TextStyle(
                                color: ThemeDefine.kTextPrimary,
                                fontSize: DesignSystem.kTextSm,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                        Icons.open_in_browser, '外部控制面板', false, (_) {}),
                  ],
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace32),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: ThemeDefine.kTextSecondary),
      title: Text(
        title,
        style: TextStyle(
          color: ThemeDefine.kTextPrimary,
          fontSize: DesignSystem.kTextBase,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSelectTile(
    IconData icon,
    String title,
    String value,
    VoidCallback onTap,
  ) {
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
          Text(
            value,
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
