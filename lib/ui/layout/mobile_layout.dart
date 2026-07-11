import 'package:flutter/material.dart';
import 'package:clashmi/ui/design_system.dart';

class MobileLayout extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;
  final List<Widget> pages;

  const MobileLayout({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.pages,
  });

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: widget.pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerTheme.color ?? Colors.transparent,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          onTap: widget.onIndexChanged,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language_outlined),
              activeIcon: Icon(Icons.language),
              label: '节点',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: '订阅',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '个人',
            ),
          ],
        ),
      ),
    );
  }
}
