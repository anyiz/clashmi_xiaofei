import 'package:flutter/material.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/ui/layout/desktop_layout.dart';
import 'package:clashmi/ui/layout/mobile_layout.dart';
import 'package:clashmi/screens/home/dashboard_screen.dart';
import 'package:clashmi/screens/nodes/node_list_screen.dart';
import 'package:clashmi/screens/subscription/subscription_screen.dart';
import 'package:clashmi/screens/profile/profile_screen.dart';
import 'package:clashmi/screens/settings/settings_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  late final List<Widget> _pages;
  late final List<Widget> _mobilePages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const DashboardScreen(),
      const NodeListScreen(),
      const SubscriptionScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];
    _mobilePages = [
      const DashboardScreen(),
      const NodeListScreen(),
      const SubscriptionScreen(),
      const ProfileScreen(),
    ];
  }

  void _onIndexChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (PlatformUtils.isPC()) {
      return DesktopLayout(
        currentIndex: _currentIndex,
        onIndexChanged: _onIndexChanged,
        pages: _pages,
      );
    } else {
      return MobileLayout(
        currentIndex: _currentIndex.clamp(0, _mobilePages.length - 1),
        onIndexChanged: _onIndexChanged,
        pages: _mobilePages,
      );
    }
  }
}
