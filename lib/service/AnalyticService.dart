import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticService {

  AnalyticService._privateConstructor();

  static final AnalyticService _instance = AnalyticService._privateConstructor();

  static AnalyticService get instance => _instance;

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() {
    _analytics.setAnalyticsCollectionEnabled(true);
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  Future logEventPage(String eventName, String pageName) async {
    await _analytics.logEvent(name: eventName, parameters: {'name': pageName});
  }
}