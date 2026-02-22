import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';

import 'analytics_service.dart';

class AnalyticsServiceImpl implements AnalyticsService {
  final FirebaseAnalytics _firebase;

  AnalyticsServiceImpl(this._firebase);

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?>? parameters,
  }) async {
    await _firebase.logEvent(
      name: name,
      parameters: parameters,
    );

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
  }
}