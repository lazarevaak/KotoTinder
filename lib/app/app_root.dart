import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/home_screen.dart';
import '../presentation/screens/breeds_list_screen.dart';
import '../presentation/screens/liked_cats_screen.dart';

import '../presentation/viewmodels/auth_viewmodel.dart';
import '../presentation/screens/auth/onboarding_screen.dart';
import '../presentation/screens/auth/login_screen.dart';

class KotoTinderApp extends StatelessWidget {
  const KotoTinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "KotoTinder",
      debugShowCheckedModeBanner: false,
      home: AppRoot(),
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    if (!auth.onboardingCompleted) {
      return const OnboardingScreen();
    }

    if (!auth.isLoggedIn) {
      return const LoginScreen();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
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
        ],
      ),
    );
  }
}
