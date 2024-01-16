import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static late ConnectivityResult _connectivityResult;

  static Future<void> initialize() async {
    _connectivityResult = await Connectivity().checkConnectivity();

    Connectivity().onConnectivityChanged.listen((result) {
      _connectivityResult = result;
    });
  }

  static Future<bool> isConnected() async {
    await initialize();
    return _connectivityResult != ConnectivityResult.none;
  }
}
