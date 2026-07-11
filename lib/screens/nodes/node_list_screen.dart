import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clashmi/app/providers/node_provider.dart';
import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/screens/nodes/node_detail_screen.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';
import 'package:clashmi/ui/widgets/glass_card.dart';

class NodeListScreen extends StatefulWidget {
  const NodeListScreen({super.key});

  @override
  State<NodeListScreen> createState() => _NodeListScreenState();
}

class _NodeListScreenState extends State<NodeListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NodeProvider>().loadNodes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeProvider>(
      builder: (context, nodeProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('节点'),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: nodeProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(DesignSystem.kSpace16),
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      SizedBox(height: DesignSystem.kSpace16),
                      _buildCategoryChips(nodeProvider),
                      SizedBox(height: DesignSystem.kSpace16),
                      ...nodeProvider.nodes.map((node) => Padding(
                            padding: EdgeInsets.only(
                                bottom: DesignSystem.kSpace12),
                            child: _buildNodeCard(context, node),
                          )),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return GlassCard(
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.kSpace16,
        vertical: DesignSystem.kSpace4,
      ),
      child: TextField(
        onChanged: (q) => context.read<NodeProvider>().search(q),
        decoration: InputDecoration(
          hintText: '搜索节点...',
          prefixIcon:
              Icon(Icons.search, color: ThemeDefine.kTextSecondary),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCategoryChips(NodeProvider nodeProvider) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: NodeProvider.categories.map((cat) {
          final selected = nodeProvider.selectedCategory == cat;
          return Padding(
            padding: EdgeInsets.only(right: DesignSystem.kSpace8),
            child: ChoiceChip(
              label: Text(cat),
              selected: selected,
              onSelected: (_) => nodeProvider.selectCategory(cat),
              selectedColor: ThemeDefine.kPrimary.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: selected
                    ? ThemeDefine.kPrimary
                    : ThemeDefine.kTextSecondary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: selected
                      ? ThemeDefine.kPrimary.withValues(alpha: 0.3)
                      : Colors.transparent,
                ),
              ),
              backgroundColor: Theme.of(context).cardTheme.color,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNodeCard(BuildContext context, ClashProxiesNode node) {
    final delayMs = node.delay;
    final delayColor = delayMs == null
        ? ThemeDefine.kTextSecondary
        : delayMs < 50
            ? ThemeDefine.kSuccess
            : delayMs < 150
                ? ThemeDefine.kWarning
                : ThemeDefine.kError;

    final flag = _getFlagEmoji(node.name);
    final country = _extractCountry(node.name);
    final city = node.name;

    return GlassCard(
      padding: EdgeInsets.all(DesignSystem.kSpace16),
      child: InkWell(
        borderRadius: BorderRadius.circular(DesignSystem.kRadiusCard),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NodeDetailScreen(node: node),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(flag, style: const TextStyle(fontSize: 24)),
                SizedBox(width: DesignSystem.kSpace12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(country,
                          style: TextStyle(
                              color: ThemeDefine.kTextPrimary,
                              fontSize: DesignSystem.kTextBase,
                              fontWeight: FontWeight.w600)),
                      Text(city,
                          style: TextStyle(
                              color: ThemeDefine.kTextSecondary,
                              fontSize: DesignSystem.kTextSm)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      delayMs != null ? '${delayMs}ms' : '--',
                      style: TextStyle(
                        color: delayColor,
                        fontSize: DesignSystem.kTextBase,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: DesignSystem.kSpace2),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: delayMs != null
                            ? (delayMs / 300).clamp(0.0, 1.0)
                            : 0,
                        backgroundColor:
                            Colors.white.withValues(alpha: 0.1),
                        valueColor:
                            AlwaysStoppedAnimation(delayColor),
                        minHeight: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: DesignSystem.kSpace12),
            Row(
              children: [
                Text(
                  node.type,
                  style: TextStyle(
                    color: ThemeDefine.kTextSecondary,
                    fontSize: DesignSystem.kTextXs,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignSystem.kSpace16,
                    vertical: DesignSystem.kSpace6,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5B7FFF), Color(0xFF8A5CFF)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '连接',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFlagEmoji(String name) {
    final countries = {
      '日本': '🇯🇵', '新加坡': '🇸🇬', '美国': '🇺🇸',
      '香港': '🇭🇰', '台湾': '🇹🇼', '韩国': '🇰🇷',
      '英国': '🇬🇧', '德国': '🇩🇪', '法国': '🇫🇷',
      '澳大利亚': '🇦🇺', '加拿大': '🇨🇦', '印度': '🇮🇳',
      '俄罗斯': '🇷🇺', '巴西': '🇧🇷', '荷兰': '🇳🇱',
    };
    for (final entry in countries.entries) {
      if (name.contains(entry.key)) return entry.value;
    }
    return '🌐';
  }

  String _extractCountry(String name) {
    final countries = [
      '日本', '新加坡', '香港', '台湾', '韩国',
      '美国', '英国', '德国', '法国',
      '澳大利亚', '加拿大', '印度', '俄罗斯',
      '巴西', '荷兰', '土耳其', '泰国', '越南',
    ];
    for (final c in countries) {
      if (name.contains(c)) return c;
    }
    return name;
  }
}
