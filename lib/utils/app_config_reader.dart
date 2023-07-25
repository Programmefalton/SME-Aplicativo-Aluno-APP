import 'dart:convert';

import 'package:flutter/services.dart';

abstract class AppConfigReader {
  static Map<String, dynamic> _config = {};

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getEnvironment() {
    return _config['environment'] as String;
  }

  static String getSentryDsn() {
    return _config['sentryDsn'] as String;
  }

  static String getErrorMessageTimeOut() {
    return _config['errorMessageTimeOut'] as String;
  }

  static String getBundleIdentifier() {
    return _config['bundleIdentifier'] as String;
  }

  static String getApiHost() {
    return _config['apiHost'] as String;
  }
}
