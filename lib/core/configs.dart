import 'package:tractian_challenge/core/injection.dart';

abstract class Config {
  Environment environment = Environment.unknown;
  bool get isProduction;
  bool get isStaging;
  bool get isLocal;
  String get baseUrl;
}

class StagingConfigs implements Config {
  @override
  Environment environment = Environment.staging;

  @override
  bool get isLocal => false;

  @override
  bool get isProduction => false;

  @override
  bool get isStaging => true;

  @override
  String get baseUrl => 'https://fake-api.tractian.com';
}
