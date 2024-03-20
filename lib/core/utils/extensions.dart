import 'package:connectivity_plus/connectivity_plus.dart';

extension DurationExtension on int {
  Duration get seconds => Duration(seconds: this);

  Duration get minutes => Duration(minutes: this);

  Duration get hours => Duration(hours: this);

  Duration get days => Duration(days: this);

  Duration get weeks => Duration(days: this * 7);

  Duration get months => Duration(days: this * 30);

  Duration get years => Duration(days: this * 365);
}

extension ConnectivityResultExtension on ConnectivityResult {
  bool get isConnected =>
      this == ConnectivityResult.mobile || this == ConnectivityResult.wifi;
}
