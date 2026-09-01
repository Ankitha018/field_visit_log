import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Future<bool> isConnected() async {
    final results = await _connectivity.checkConnectivity();

    final hasNetwork = _hasConnection(results);

    if (!hasNetwork) {
      return false;
    }

    try {
      final result = await InternetAddress.lookup('example.com');

      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  Stream<bool> get connectionStream {
    return _connectivity.onConnectivityChanged
        .asyncMap((results) => _checkInternetConnection(results))
        .distinct();
  }

  Future<bool> _checkInternetConnection(
    List<ConnectivityResult> results,
  ) async {
    if (!_hasConnection(results)) {
      return false;
    }

    try {
      final result = await InternetAddress.lookup('example.com');

      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}
