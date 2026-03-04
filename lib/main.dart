import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/app.dart';

import 'data/datasources/storage/cat_hive_model.dart';

import 'app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.secrets');
  await _initAppMetrica();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  if (kDebugMode) {
    await FirebaseAnalytics.instance.logEvent(
      name: 'debug_ping',
      parameters: {
        'stage': 'startup',
      },
    );
  }

  await Hive.initFlutter();
  Hive.registerAdapter(CatHiveModelAdapter());
  final box = await Hive.openBox<CatHiveModel>('liked_cats');

  final prefs = await SharedPreferences.getInstance();

  runApp(
    App(
      box: box,
      prefs: prefs,
    ),
  );
}

Future<void> _initAppMetrica() async {
  final apiKey = dotenv.maybeGet('APPMETRICA_API_KEY');
  if (apiKey == null || apiKey.isEmpty) {
    if (kDebugMode) {
      debugPrint('[AppMetrica] APPMETRICA_API_KEY is empty');
    }
    return;
  }

  await AppMetrica.activate(
    AppMetricaConfig(
      apiKey,
      logs: kDebugMode,
    ),
  );
}
