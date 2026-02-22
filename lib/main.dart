import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app.dart';

import 'data/datasources/storage/cat_hive_model.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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