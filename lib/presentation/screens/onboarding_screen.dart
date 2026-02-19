import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          _page("Swipe cats", "Like or dislike cats 🐱"),
          _page("Breeds", "Learn about breeds 🐾"),
          _page("Favorites", "Save your favorites ❤️"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthViewModel>().completeOnboarding();
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget _page(String title, String subtitle) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(size: 120), 
          const SizedBox(height: 24),
          Text(title, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Text(subtitle),
        ],
      ),
    );
  }
}
