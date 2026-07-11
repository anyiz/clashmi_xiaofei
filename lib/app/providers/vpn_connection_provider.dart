import 'package:flutter/material.dart';
import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/biz.dart';
import 'package:libclash_vpn_service/state.dart';

enum VpnStatus { disconnected, connecting, connected }

class VpnConnectionProvider extends ChangeNotifier {
  VpnStatus _status = VpnStatus.disconnected;
  String _traffic = '';
  String _speed = '';
  String _duration = '';
  String _selectedNode = '';

  VpnStatus get status => _status;
  String get traffic => _traffic;
  String get speed => _speed;
  String get duration => _duration;
  String get selectedNode => _selectedNode;
  bool get isConnected => _status == VpnStatus.connected;

  VpnConnectionProvider() {
    // Listen to VPN state changes
    VPNService.onEventStateChanged.add(_onVpnStateChanged);
    Biz.onEventTrafficChanged.add(_onTrafficChanged);
    Biz.onEventVPNStateChanged = _onBizVpnStateChanged;
  }

  void _onVpnStateChanged(FlutterVpnServiceState state, Map<String, String> params) {
    switch (state) {
      case FlutterVpnServiceState.connecting:
        _status = VpnStatus.connecting;
      case FlutterVpnServiceState.connected:
        _status = VpnStatus.connected;
      case FlutterVpnServiceState.disconnected:
        _status = VpnStatus.disconnected;
      case FlutterVpnServiceState.disconnecting:
        _status = VpnStatus.connecting;
    }
    notifyListeners();
  }

  void _onBizVpnStateChanged(bool isConnected) {
    _status = isConnected ? VpnStatus.connected : VpnStatus.disconnected;
    notifyListeners();
  }

  void _onTrafficChanged(String traffic, String speed) {
    _traffic = traffic;
    _speed = speed;
    notifyListeners();
  }

  Future<void> toggleConnection() async {
    if (_status == VpnStatus.connected) {
      _status = VpnStatus.connecting;
      notifyListeners();
      await VPNService.stop();
    } else {
      _status = VpnStatus.connecting;
      notifyListeners();
      await VPNService.start(const Duration(seconds: 60));
    }
  }

  @override
  void dispose() {
    VPNService.onEventStateChanged.remove(_onVpnStateChanged);
    Biz.onEventTrafficChanged.remove(_onTrafficChanged);
    super.dispose();
  }
}
