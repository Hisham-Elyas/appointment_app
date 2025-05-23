import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImp(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

class NetworkInfoImp2 implements NetworkInfo {
  @override
  Future<bool> get isConnected => ckeckInternet();
}

Future<bool> ckeckInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
  // return true;  // in loclhost
}
