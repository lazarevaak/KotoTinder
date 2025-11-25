import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/home_screen.dart';

import 'views/breeds_list_screen.dart';
import 'views/liked_cats_screen.dart';
import 'viewmodels/cat_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CatViewModel()..loadCat(),
      child: const KotoTinderApp(),
    ),
  );
}

class KotoTinderApp extends StatelessWidget {
  const KotoTinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KotoTinder",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F5FA),
        primaryColor: const Color(0xFF4FD5D0),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF4FD5D0),
          unselectedItemColor: Colors.black26,
          elevation: 8,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
      ),
      home: const RootTabBar(),
    );
  }
}

class RootTabBar extends StatefulWidget {
  const RootTabBar({super.key});

  @override
  State<RootTabBar> createState() => _RootTabBarState();
}

class _RootTabBarState extends State<RootTabBar> {
  int index = 0;

  final screens = const [HomeScreen(), BreedsListScreen(), LikedCatsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Cats"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Breeds"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
        ],
      ),
    );
  }
}
