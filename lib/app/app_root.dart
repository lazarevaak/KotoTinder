import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/bar_items/home_screen.dart';
import '../presentation/screens/bar_items/breeds_list_screen.dart';
import '../presentation/screens/bar_items/liked_cats_screen.dart';

import '../presentation/viewmodels/auth_viewmodel.dart';
import '../data/datasources/services/analytics_service.dart';
import '../presentation/screens/auth/onboarding_screen.dart';
import '../presentation/screens/auth/login_screen.dart';

class KotoTinderApp extends StatelessWidget {
  const KotoTinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KotoTinder",
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return _GlobalTapLogger(
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const AppRoot(),
    );
  }
}

class _GlobalTapLogger extends StatefulWidget {
  final Widget child;

  const _GlobalTapLogger({
    required this.child,
  });

  @override
  State<_GlobalTapLogger> createState() => _GlobalTapLoggerState();
}

class _GlobalTapLoggerState extends State<_GlobalTapLogger> {
  DateTime _lastSentAt = DateTime.fromMillisecondsSinceEpoch(0);

  void _logTap() {
    if (!kDebugMode) {
      return;
    }

    final now = DateTime.now();
    if (now.difference(_lastSentAt) < const Duration(milliseconds: 700)) {
      return;
    }
    _lastSentAt = now;

    unawaited(
      context.read<AnalyticsService>().logEvent(
        'app_tap',
        parameters: {
          'source': 'global',
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _logTap(),
      child: widget.child,
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    if (!auth.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!auth.isLoggedIn) {
      return const LoginScreen();
    }

    if (!auth.onboardingCompleted) {
      return const OnboardingScreen();
    }

    return const RootTabBar();
  }
}

class RootTabBar extends StatefulWidget {
  const RootTabBar({super.key});

  @override
  State<RootTabBar> createState() => _RootTabBarState();
}

class _RootTabBarState extends State<RootTabBar> {
  int index = 0;

  final screens = const [
    HomeScreen(),
    BreedsListScreen(),
    LikedCatsScreen(),
  ];

  Future<void> _onItemTapped(BuildContext context, int i) async {
    unawaited(
      context.read<AnalyticsService>().logEvent(
        'tab_tap',
        parameters: {
          'index': i,
        },
      ),
    );

    if (i == 3) {
      final shouldLogout =
          await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Logout"),
              content: const Text("Do you want to log out of your account?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Logout"),
                ),
              ],
            ),
          ) ??
          false;

      if (shouldLogout && context.mounted) {
        await context.read<AuthViewModel>().logout();
      }
      return;
    }

    setState(() => index = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey.shade700,
        currentIndex: index,
        onTap: (i) => _onItemTapped(context, i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: "Cats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Breeds",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Liked",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Logout",
          ),
        ],
      ),
    );
  }
}
