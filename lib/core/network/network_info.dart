import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Abstract class defining the contract for checking network connectivity.
abstract class NetworkInfo {
  /// Checks if the device is currently connected to the internet.
  ///
  /// Returns a [Future] that completes with a boolean value indicating
  /// whether the device has an active internet connection (`true`) or not (`false`).
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] that uses [InternetConnectionChecker]
/// to determine network connectivity status.
///
/// This class provides a concrete implementation of [NetworkInfo] interface
/// using [InternetConnectionChecker] for checking if the device is connected
/// to the internet.
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  /// Constructs a [NetworkInfoImpl] instance with the provided [connectionChecker].
  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
