import 'package:flutter/material.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/widgets/mini_player_bar.dart';

class DesktopLayout extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;
  final List<Widget> pages;

  const DesktopLayout({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.pages,
  });

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  bool _isRailExtended = false;
  late final List<NavigationDestination> _destinations;

  @override
  void initState() {
    super.initState();
    _destinations = [
      NavigationDestination(
        icon: Icon(Icons.home_outlined, size: DesignSystem.kIconMedium),
        selectedIcon: Icon(Icons.home, size: DesignSystem.kIconMedium),
        label: '首页',
      ),
      NavigationDestination(
        icon: Icon(Icons.language_outlined, size: DesignSystem.kIconMedium),
        selectedIcon: Icon(Icons.language, size: DesignSystem.kIconMedium),
        label: '节点',
      ),
      NavigationDestination(
        icon: Icon(Icons.subscriptions_outlined, size: DesignSystem.kIconMedium),
        selectedIcon: Icon(Icons.subscriptions, size: DesignSystem.kIconMedium),
        label: '订阅',
      ),
      NavigationDestination(
        icon: Icon(Icons.person_outline, size: DesignSystem.kIconMedium),
        selectedIcon: Icon(Icons.person, size: DesignSystem.kIconMedium),
        label: '个人',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_outlined, size: DesignSystem.kIconMedium),
        selectedIcon: Icon(Icons.settings, size: DesignSystem.kIconMedium),
        label: '设置',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Navigation Rail
        MouseRegion(
          onEnter: (_) => setState(() => _isRailExtended = true),
          onExit: (_) => setState(() => _isRailExtended = false),
          child: AnimatedContainer(
            duration: DesignSystem.kDurationNormal,
            curve: DesignSystem.kSpringCurve,
            width: _isRailExtended
                ? DesignSystem.kNavRailExtendedWidth
                : DesignSystem.kNavRailWidth,
            child: NavigationRail(
              backgroundColor: Theme.of(context).colorScheme.surface,
              extended: _isRailExtended,
              labelType: _isRailExtended
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              selectedIndex: widget.currentIndex,
              onDestinationSelected: widget.onIndexChanged,
              leading: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: DesignSystem.kSpace16,
                ),
                child: _buildLogo(_isRailExtended),
              ),
              destinations: _destinations.map((d) {
                return NavigationRailDestination(
                  icon: d.icon,
                  selectedIcon: d.selectedIcon,
                  label: Text(d.label),
                );
              }).toList(),
              trailing: Padding(
                padding: EdgeInsets.only(bottom: DesignSystem.kSpace8),
                child: SizedBox(
                  height: DesignSystem.kMiniPlayerHeight,
                  child: MiniPlayerBar(
                    isExtended: _isRailExtended,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Divider
        VerticalDivider(
          width: 1,
          thickness: 1,
          color: Theme.of(context).dividerTheme.color,
        ),
        // Content area
        Expanded(
          child: IndexedStack(
            index: widget.currentIndex,
            children: widget.pages,
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(bool extended) {
    return Center(
      child: extended
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLogoIcon(),
                SizedBox(width: DesignSystem.kSpace8),
                Text(
                  'Premium VPN',
                  style: TextStyle(
                    fontSize: DesignSystem.kTextLg,
                    fontWeight: FontWeight.bold,
                    color: ThemeDefine.kTextPrimary,
                  ),
                ),
              ],
            )
          : _buildLogoIcon(),
    );
  }

  Widget _buildLogoIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ThemeDefine.kPrimary, ThemeDefine.kAccent],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.shield_outlined,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
