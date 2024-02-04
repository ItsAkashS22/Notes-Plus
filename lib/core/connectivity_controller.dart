import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  Stream<ConnectivityResult> get connectivityStream =>
      Connectivity().onConnectivityChanged;

  ConnectivityResult get connectivityResult => _connectivityResult;

  Future<void> checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    _updateConnectivityResult(result);
  }

  void _updateConnectivityResult(ConnectivityResult result) {
    _connectivityResult = result;
  }

  Future<void> startListening() async {
    await checkConnectivity();
    connectivityStream.listen(_updateConnectivityResult);
  }
}
