import 'package:firebase_analytics/firebase_analytics.dart';

import 'analytics_service.dart';

class FirebaseAnalyticsService implements AnalyticsService {
  final FirebaseAnalytics analytics;

  FirebaseAnalyticsService(this.analytics);

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?>? parameters,
  }) {
    return analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}