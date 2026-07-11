import 'package:flutter/material.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';

class MiniPlayerBar extends StatelessWidget {
  final bool isExtended;

  const MiniPlayerBar({super.key, this.isExtended = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isExtended ? DesignSystem.kSpace12 : DesignSystem.kSpace4,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.kSpace8,
        vertical: DesignSystem.kSpace8,
      ),
      decoration: BoxDecoration(
        color: ThemeDefine.kPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DesignSystem.kRadiusStandard),
      ),
      child: isExtended
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatusDot(),
                SizedBox(width: DesignSystem.kSpace8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '已断开',
                        style: TextStyle(
                          fontSize: DesignSystem.kTextXs,
                          color: ThemeDefine.kTextSecondary,
                        ),
                      ),
                      Text(
                        '0.00 KB/s',
                        style: TextStyle(
                          fontSize: DesignSystem.kTextXs,
                          color: ThemeDefine.kTextPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatusDot(),
                SizedBox(height: DesignSystem.kSpace4),
                Icon(
                  Icons.swap_vert,
                  size: 14,
                  color: ThemeDefine.kTextSecondary,
                ),
              ],
            ),
    );
  }

  Widget _buildStatusDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.4),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}
