import 'package:flutter/material.dart';
import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/widgets/glass_card.dart';

class NodeDetailScreen extends StatelessWidget {
  final ClashProxiesNode node;

  const NodeDetailScreen({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final delayMs = node.delay;
    final delayColor = delayMs == null
        ? ThemeDefine.kTextSecondary
        : delayMs < 50
            ? ThemeDefine.kSuccess
            : delayMs < 150
                ? ThemeDefine.kWarning
                : ThemeDefine.kError;

    final flag = _getFlagEmoji(node.name);

    return Scaffold(
      appBar: AppBar(
        title: Text('$flag ${node.name}'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignSystem.kSpace16),
        child: Column(
          children: [
            GlassCard(
              padding: EdgeInsets.all(DesignSystem.kSpace24),
              child: Column(
                children: [
                  Text(flag, style: const TextStyle(fontSize: 48)),
                  SizedBox(height: DesignSystem.kSpace12),
                  Text(
                    delayMs != null ? '${delayMs}ms' : '未测试',
                    style: TextStyle(
                      color: delayColor,
                      fontSize: DesignSystem.kText3xl,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: DesignSystem.kSpace8),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DesignSystem.kSpace12,
                      vertical: DesignSystem.kSpace4,
                    ),
                    decoration: BoxDecoration(
                      color: delayColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '🟢 ${node.type}',
                      style: TextStyle(
                        color: delayColor,
                        fontSize: DesignSystem.kTextSm,
                      ),
                    ),
                  ),
                  SizedBox(height: DesignSystem.kSpace8),
                  Text(
                    node.name,
                    style: TextStyle(
                      color: ThemeDefine.kTextSecondary,
                      fontSize: DesignSystem.kTextBase,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace16),

            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                      '延迟', delayMs != null ? '${delayMs}ms' : '--',
                      ThemeDefine.kPrimary, Icons.speed),
                ),
                SizedBox(width: DesignSystem.kSpace12),
                Expanded(
                  child: _buildMetricCard('抖动', '--ms',
                      ThemeDefine.kAccent, Icons.timeline),
                ),
                SizedBox(width: DesignSystem.kSpace12),
                Expanded(
                  child: _buildMetricCard('可用率', '--%',
                      ThemeDefine.kSuccess, Icons.check_circle_outline),
                ),
              ],
            ),
            SizedBox(height: DesignSystem.kSpace24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('流媒体支持检测',
                  style: TextStyle(
                      color: ThemeDefine.kTextPrimary,
                      fontSize: DesignSystem.kTextLg,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: DesignSystem.kSpace12),
            GlassCard(
              padding: EdgeInsets.all(DesignSystem.kSpace16),
              child: Wrap(
                spacing: DesignSystem.kSpace8,
                runSpacing: DesignSystem.kSpace8,
                children: [
                  _buildSupportBadge('OpenAI', true),
                  _buildSupportBadge('Claude', true),
                  _buildSupportBadge('Netflix', true),
                  _buildSupportBadge('YouTube', true),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('节点信息',
                  style: TextStyle(
                      color: ThemeDefine.kTextPrimary,
                      fontSize: DesignSystem.kTextLg,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: DesignSystem.kSpace12),
            GlassCard(
              padding: EdgeInsets.all(DesignSystem.kSpace16),
              child: Column(
                children: [
                  _buildInfoRow('节点名称', node.name),
                  _buildDivider(),
                  _buildInfoRow('类型', node.type),
                  _buildDivider(),
                  _buildInfoRow('延迟', delayMs != null ? '${delayMs}ms' : '未测试'),
                  _buildDivider(),
                  _buildInfoRow('隐藏', node.hidden ? '是' : '否'),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B7FFF), Color(0xFF8A5CFF)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Select this node in its group
                  },
                  icon: const Icon(Icons.power_settings_new,
                      color: Colors.white),
                  label: const Text('连接此节点',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: DesignSystem.kSpace32),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
      String label, String value, Color color, IconData icon) {
    return GlassCard(
      padding: EdgeInsets.all(DesignSystem.kSpace16),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: DesignSystem.kSpace4),
          Text(value,
              style: TextStyle(
                  color: ThemeDefine.kTextPrimary,
                  fontSize: DesignSystem.kTextBase,
                  fontWeight: FontWeight.bold)),
          Text(label,
              style: TextStyle(
                  color: ThemeDefine.kTextSecondary,
                  fontSize: DesignSystem.kTextXs)),
        ],
      ),
    );
  }

  Widget _buildSupportBadge(String name, bool supported) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.kSpace12,
        vertical: DesignSystem.kSpace6,
      ),
      decoration: BoxDecoration(
        color: supported
            ? ThemeDefine.kSuccess.withValues(alpha: 0.1)
            : ThemeDefine.kError.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            supported ? Icons.check : Icons.close,
            size: 14,
            color: supported ? ThemeDefine.kSuccess : ThemeDefine.kError,
          ),
          SizedBox(width: DesignSystem.kSpace4),
          Text(name,
              style: TextStyle(
                  color:
                      supported ? ThemeDefine.kSuccess : ThemeDefine.kError,
                  fontSize: DesignSystem.kTextSm,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: DesignSystem.kSpace8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: ThemeDefine.kTextSecondary,
                  fontSize: DesignSystem.kTextBase)),
          Text(value,
              style: TextStyle(
                  color: ThemeDefine.kTextPrimary,
                  fontSize: DesignSystem.kTextBase,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: Colors.white.withValues(alpha: 0.06),
    );
  }

  String _getFlagEmoji(String name) {
    final countries = {
      '日本': '🇯🇵', '新加坡': '🇸🇬', '美国': '🇺🇸',
      '香港': '🇭🇰', '台湾': '🇹🇼', '韩国': '🇰🇷',
      '英国': '🇬🇧', '德国': '🇩🇪', '法国': '🇫🇷',
      '澳大利亚': '🇦🇺', '加拿大': '🇨🇦', '印度': '🇮🇳',
    };
    for (final entry in countries.entries) {
      if (name.contains(entry.key)) return entry.value;
    }
    return '🌐';
  }
}
