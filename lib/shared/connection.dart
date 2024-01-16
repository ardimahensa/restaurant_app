import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  static Stream<bool> isConnectInternet() {
    return Connectivity().onConnectivityChanged.map((event) {
      return event != ConnectivityResult.none;
    });
  }
}
