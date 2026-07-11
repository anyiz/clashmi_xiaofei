import 'package:flutter/material.dart';
import 'package:clashmi/app/clash/clash_http_api.dart';

class NodeProvider extends ChangeNotifier {
  List<ClashProxiesNode> _nodes = [];
  List<ClashProxiesNode> _filteredNodes = [];
  String _searchQuery = '';
  String _selectedCategory = '全部';
  bool _isLoading = false;

  List<ClashProxiesNode> get nodes =>
      _searchQuery.isEmpty && _selectedCategory == '全部'
          ? _nodes
          : _filteredNodes;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  static const categories = ['全部', 'AI', '流媒体', '游戏', '全球'];

  Future<void> loadNodes() async {
    _isLoading = true;
    notifyListeners();

    final result = await ClashHttpApi.getProxies();
    if (result.error == null) {
      _nodes = result.data!;
      _applyFilters();
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredNodes = _nodes.where((node) {
      // Skip group nodes (Selector, URLTest, etc) and keep leaf nodes
      if (node.type == 'Selector' ||
          node.type == 'URLTest' ||
          node.type == 'Fallback' ||
          node.type == 'LoadBalance') {
        return false;
      }

      // Filter by search
      if (_searchQuery.isNotEmpty &&
          !node.name.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }

      return true;
    }).toList();
    notifyListeners();
  }

  Future<int?> testDelay(String nodeName) async {
    final result = await ClashHttpApi.getDelay(nodeName, 'http://www.gstatic.com/generate_204');
    if (result.error == null) {
      return result.data;
    }
    return null;
  }

  Future<void> selectNode(String groupName, String nodeName) async {
    await ClashHttpApi.setProxiesNode(groupName, nodeName);
    await loadNodes();
  }
}
