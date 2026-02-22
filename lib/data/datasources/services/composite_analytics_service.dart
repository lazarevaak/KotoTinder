import 'analytics_service.dart';

class CompositeAnalyticsService implements AnalyticsService {
  final List<AnalyticsService> services;

  CompositeAnalyticsService(this.services);

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?>? parameters,
  }) async {
    for (final service in services) {
      try {
        await service.logEvent(name, parameters: parameters);
      } catch (_) {
      }
    }
  }
}