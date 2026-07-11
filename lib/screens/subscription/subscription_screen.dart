import 'package:flutter/material.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/widgets/glass_card.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的订阅'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignSystem.kSpace16),
        child: Column(
          children: [
            // Current plan card
            GlassCard(
              padding: EdgeInsets.all(DesignSystem.kSpace24),
              child: Column(
                children: [
                  // Traffic gauge
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 140,
                          child: CircularProgressIndicator(
                            value: 0.45,
                            strokeWidth: 8,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.1),
                            valueColor: AlwaysStoppedAnimation(
                              ThemeDefine.kPrimary,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '45.2',
                              style: TextStyle(
                                color: ThemeDefine.kTextPrimary,
                                fontSize: DesignSystem.kText3xl,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'GB / 100GB',
                              style: TextStyle(
                                color: ThemeDefine.kTextSecondary,
                                fontSize: DesignSystem.kTextSm,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: DesignSystem.kSpace16),
                  Text(
                    '剩余 54.8 GB',
                    style: TextStyle(
                      color: ThemeDefine.kSuccess,
                      fontSize: DesignSystem.kTextBase,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: DesignSystem.kSpace16),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                  SizedBox(height: DesignSystem.kSpace16),
                  _buildInfoRow('当前套餐', 'Premium 年度会员'),
                  SizedBox(height: DesignSystem.kSpace8),
                  _buildInfoRow('状态', '🟢 生效中'),
                  SizedBox(height: DesignSystem.kSpace8),
                  _buildInfoRow('过期', '2027-01-20'),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.kSpace16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton('升级套餐', Icons.upgrade, () {}),
                ),
                SizedBox(width: DesignSystem.kSpace12),
                Expanded(
                  child: _buildActionButton(
                    '购买流量',
                    Icons.add_circle_outline,
                    () {},
                  ),
                ),
                SizedBox(width: DesignSystem.kSpace12),
                Expanded(
                  child: _buildActionButton(
                    '邀请好友',
                    Icons.share_outlined,
                    () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: DesignSystem.kSpace24),

            // Plan list
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '套餐列表',
                style: TextStyle(
                  color: ThemeDefine.kTextPrimary,
                  fontSize: DesignSystem.kTextLg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: DesignSystem.kSpace12),
            _buildPlanCard('基础版', '¥29/月', '10GB 流量', '1 设备', false),
            SizedBox(height: DesignSystem.kSpace12),
            _buildPlanCard(
              'Premium',
              '¥89/月',
              '100GB 流量',
              '5 设备',
              true,
              badge: '当前套餐',
              features: 'OpenAI加速',
            ),
            SizedBox(height: DesignSystem.kSpace12),
            _buildPlanCard(
              '无限版',
              '¥199/月',
              '无限流量',
              '不限设备',
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ThemeDefine.kTextSecondary,
            fontSize: DesignSystem.kTextSm,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: ThemeDefine.kTextPrimary,
            fontSize: DesignSystem.kTextSm,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return GlassCard(
      padding: EdgeInsets.all(DesignSystem.kSpace16),
      child: InkWell(
        borderRadius: BorderRadius.circular(DesignSystem.kRadiusCard),
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, color: ThemeDefine.kPrimary, size: 28),
            SizedBox(height: DesignSystem.kSpace8),
            Text(
              label,
              style: TextStyle(
                color: ThemeDefine.kTextPrimary,
                fontSize: DesignSystem.kTextSm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    String name,
    String price,
    String traffic,
    String devices,
    bool isCurrent, {
    String? badge,
    String? features,
  }) {
    return GlassCard(
      padding: EdgeInsets.all(DesignSystem.kSpace16),
      child: Container(
        decoration: isCurrent
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: ThemeDefine.kPrimary.withValues(alpha: 0.3),
                ),
              )
            : null,
        child: Row(
          children: [
            Radio<String>(
              value: name,
              groupValue: isCurrent ? name : null,
              onChanged: (_) {},
              fillColor: WidgetStateProperty.resolveWith(
                (_) => ThemeDefine.kPrimary,
              ),
            ),
            SizedBox(width: DesignSystem.kSpace8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: ThemeDefine.kTextPrimary,
                          fontSize: DesignSystem.kTextBase,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (badge != null) ...[
                        SizedBox(width: DesignSystem.kSpace8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: DesignSystem.kSpace8,
                            vertical: DesignSystem.kSpace2,
                          ),
                          decoration: BoxDecoration(
                            color: ThemeDefine.kPrimary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              color: ThemeDefine.kPrimary,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: DesignSystem.kSpace4),
                  Text(
                    price,
                    style: TextStyle(
                      color: ThemeDefine.kPrimary,
                      fontSize: DesignSystem.kTextLg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$traffic · $devices${features != null ? ' · $features' : ''}',
                    style: TextStyle(
                      color: ThemeDefine.kTextSecondary,
                      fontSize: DesignSystem.kTextSm,
                    ),
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
