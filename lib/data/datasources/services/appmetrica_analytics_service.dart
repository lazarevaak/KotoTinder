import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'analytics_service.dart';

class AppMetricaAnalyticsService implements AnalyticsService {
  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?>? parameters,
  }) async {
    if (parameters == null || parameters.isEmpty) {
      await AppMetrica.reportEvent(name);
      return;
    }

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