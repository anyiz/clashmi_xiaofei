import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clashmi/app/providers/vpn_connection_provider.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/widgets/glass_card.dart';
import 'package:clashmi/ui/widgets/liquid_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VpnConnectionProvider>(
      builder: (context, vpn, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('首页'),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(DesignSystem.kSpace16),
            child: Column(
              children: [
                SizedBox(height: DesignSystem.kSpace24),
                _buildConnectButton(context, vpn),
                SizedBox(height: DesignSystem.kSpace24),
                _buildTrafficCards(vpn),
                SizedBox(height: DesignSystem.kSpace16),
                _buildStatusCard(vpn),
                SizedBox(height: DesignSystem.kSpace16),
                _buildPerformanceRow(),
                SizedBox(height: DesignSystem.kSpace16),
                _buildRecommendedSection(context),
                SizedBox(height: DesignSystem.kSpace16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConnectButton(BuildContext context, VpnConnectionProvider vpn) {
    LiquidButtonState state;
    switch (vpn.status) {
      case VpnStatus.disconnected:
        state = LiquidButtonState.disconnected;
      case VpnStatus.connecting:
        state = LiquidButtonState.connecting;
      case VpnStatus.connected:
        state = LiquidButtonState.connected;
    }

    return LiquidConnectButton(
      state: state,
      onTap: () => vpn.toggleConnection(),
    );
  }

  Widget _buildTrafficCards(VpnConnectionProvider vpn) {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            padding: EdgeInsets.all(DesignSystem.kSpace16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(DesignSystem.kSpace4),
                      decoration: BoxDecoration(
                        color: ThemeDefine.kPrimary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.arrow_upward,
                          color: ThemeDefine.kPrimary, size: 16),
                    ),
                    SizedBox(width: DesignSystem.kSpace8),
                    Text('上传',
                        style: TextStyle(
                            color: ThemeDefine.kTextSecondary,
                            fontSize: DesignSystem.kTextSm)),
                  ],
                ),
                SizedBox(height: DesignSystem.kSpace8),
                Text(
                  vpn.traffic.isNotEmpty ? vpn.traffic : '0.00 KB/s',
                  style: TextStyle(
                    color: ThemeDefine.kTextPrimary,
                    fontSize: DesignSystem.kTextXl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: DesignSystem.kSpace12),
        Expanded(
          child: GlassCard(
            padding: EdgeInsets.all(DesignSystem.kSpace16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(DesignSystem.kSpace4),
                      decoration: BoxDecoration(
                        color: ThemeDefine.kSuccess.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.arrow_downward,
                          color: ThemeDefine.kSuccess, size: 16),
                    ),
                    SizedBox(width: DesignSystem.kSpace8),
                    Text('下载',
                        style: TextStyle(
                            color: ThemeDefine.kTextSecondary,
                            fontSize: DesignSystem.kTextSm)),
                  ],
                ),
                SizedBox(height: DesignSystem.kSpace8),
                Text(
                  vpn.speed.isNotEmpty ? vpn.speed : '0.00 KB/s',
                  style: TextStyle(
                    color: ThemeDefine.kTextPrimary,
                    fontSize: DesignSystem.kTextXl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: DesignSystem.kSpace12),
        Expanded(
          child: GlassCard(
            padding: EdgeInsets.all(DesignSystem.kSpace16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(DesignSystem.kSpace4),
                      decoration: BoxDecoration(
                        color: ThemeDefine.kWarning.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.data_usage,
                          color: ThemeDefine.kWarning, size: 16),
                    ),
                    SizedBox(width: DesignSystem.kSpace8),
                    Text('剩余',
                        style: TextStyle(
                            color: ThemeDefine.kTextSecondary,
                            fontSize: DesignSystem.kTextSm)),
                  ],
                ),
                SizedBox(height: DesignSystem.kSpace8),
                Text(
                  '100.0 GB',
                  style: TextStyle(
                    color: ThemeDefine.kTextPrimary,
                    fontSize: DesignSystem.kTextXl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(VpnConnectionProvider vpn) {
    final isConnected = vpn.isConnected;
    return GlassCard(
      padding: EdgeInsets.all(DesignSystem.kSpace16),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isConnected ? ThemeDefine.kSuccess : Colors.grey,
              shape: BoxShape.circle,
              boxShadow: isConnected
                  ? [
                      BoxShadow(
                        color: ThemeDefine.kSuccess.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ]
                  : null,
            ),
          ),
          SizedBox(width: DesignSystem.kSpace12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isConnected ? '状态: 已连接' : '状态: 未连接',
                  style: TextStyle(
                    color: ThemeDefine.kTextPrimary,
                    fontSize: DesignSystem.kTextBase,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: DesignSystem.kSpace4),
                Text(
                  isConnected ? vpn.speed : '点击上方按钮开始连接',
                  style: TextStyle(
                    color: ThemeDefine.kTextSecondary,
                    fontSize: DesignSystem.kTextSm,
                  ),
                ),
              ],
            ),
          ),
          if (isConnected)
            IconButton(
              icon: Icon(Icons.autorenew, color: ThemeDefine.kTextSecondary),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget _buildPerformanceRow() {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            padding: EdgeInsets.all(DesignSystem.kSpace16),
            child: Column(
              children: [
                Icon(Icons.speed, color: ThemeDefine.kPrimary, size: 24),
                SizedBox(height: DesignSystem.kSpace4),
                Text('-- ms',
                    style: TextStyle(
                        color: ThemeDefine.kTextPrimary,
                        fontSize: DesignSystem.kTextBase,
                        fontWeight: FontWeight.bold)),
                Text('延迟',
                    style: TextStyle(
                        color: ThemeDefine.kTextSecondary,
                        fontSize: DesignSystem.kTextXs)),
              ],
            ),
          ),
        ),
        SizedBox(width: DesignSystem.kSpace12),
        Expanded(
          child: GlassCard(
            padding: EdgeInsets.all(DesignSystem.kSpace16),
            child: Column(
              children: [
                Icon(Icons.timeline, color: ThemeDefine.kAccent, size: 24),
                SizedBox(height: DesignSystem.kSpace4),
                Text('-- ms',
                    style: TextStyle(
                        color: ThemeDefine.kTextPrimary,
                        fontSize: DesignSystem.kTextBase,
                        fontWeight: FontWeight.bold)),
                Text('抖动',
                    style: TextStyle(
                        color: ThemeDefine.kTextSecondary,
                        fontSize: DesignSystem.kTextXs)),
              ],
            ),
          ),
        ),
        SizedBox(width: DesignSystem.kSpace12),
        Expanded(
          child: GlassCard(
            padding: EdgeInsets.all(DesignSystem.kSpace16),
            child: Column(
              children: [
                Icon(Icons.check_circle_outline,
                    color: ThemeDefine.kSuccess, size: 24),
                SizedBox(height: DesignSystem.kSpace4),
                Text('--%',
                    style: TextStyle(
                        color: ThemeDefine.kTextPrimary,
                        fontSize: DesignSystem.kTextBase,
                        fontWeight: FontWeight.bold)),
                Text('可用率',
                    style: TextStyle(
                        color: ThemeDefine.kTextSecondary,
                        fontSize: DesignSystem.kTextXs)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('推荐节点',
                style: TextStyle(
                    color: ThemeDefine.kTextPrimary,
                    fontSize: DesignSystem.kTextLg,
                    fontWeight: FontWeight.w600)),
            TextButton(
              onPressed: () {
                // Navigate to nodes tab
              },
              child: Text('查看更多 →'),
            ),
          ],
        ),
        SizedBox(height: DesignSystem.kSpace12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildRecommendedNodeCard('🇯🇵', '日本-东京', '23ms', '45%'),
              SizedBox(width: DesignSystem.kSpace12),
              _buildRecommendedNodeCard('🇸🇬', '新加坡-01', '45ms', '30%'),
              SizedBox(width: DesignSystem.kSpace12),
              _buildRecommendedNodeCard('🇺🇸', '美国-洛杉矶', '180ms', '60%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedNodeCard(
      String flag, String name, String delay, String load) {
    return GlassCard(
      width: 160,
      padding: EdgeInsets.all(DesignSystem.kSpace16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(flag, style: const TextStyle(fontSize: 28)),
          SizedBox(height: DesignSystem.kSpace8),
          Text(name,
              style: TextStyle(
                  color: ThemeDefine.kTextPrimary,
                  fontSize: DesignSystem.kTextSm,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: DesignSystem.kSpace4),
          Row(
            children: [
              Text(delay,
                  style: TextStyle(
                      color: ThemeDefine.kSuccess,
                      fontSize: DesignSystem.kTextXs)),
              SizedBox(width: DesignSystem.kSpace8),
              Text('负载 $load',
                  style: TextStyle(
                      color: ThemeDefine.kTextSecondary,
                      fontSize: DesignSystem.kTextXs)),
            ],
          ),
        ],
      ),
    );
  }
}
