import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';

import 'analytics_service.dart';

class AnalyticsServiceImpl implements AnalyticsService {
  final FirebaseAnalytics _firebase;

  AnalyticsServiceImpl(this._firebase);

  void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[Analytics] $message');
    }
  }

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?>? parameters,
  }) async {
    _debugLog('event="$name" params=$parameters');

    try {
      await _firebase.logEvent(
        name: name,
        parameters: parameters,
      );
      _debugLog('Firebase OK: "$name"');
    } catch (e, st) {
      _debugLog('Firebase ERROR: "$name" -> $e');
      _debugLog(st.toString());
    }

    try {
      if (parameters == null || parameters.isEmpty) {
        await AppMetrica.reportEvent(name);
      } else {
        final cleanedParams = <String, Object>{};

        parameters.forEach((key, value) {
          if (value != null) {
            cleanedParams[key] = value;
          }
        });

        await AppMetrica.reportEventWithMap(
          name,
          cleanedParams,
        );
      }

      _debugLog('AppMetrica OK: "$name"');
    } catch (e, st) {
      _debugLog('AppMetrica ERROR: "$name" -> $e');
      _debugLog(st.toString());
    }
  }
}
