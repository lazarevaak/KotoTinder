import 'package:flutter/material.dart';

Widget testAppWrapper(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: child,
    ),
  );
}