import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';

import '../../../domain/entities/onboarding_page.dart';

import 'widgets/bottom_buttons.dart';
import 'widgets/background.dart';
import 'widgets/indicators.dart';
import 'widgets/onboarding_pager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller =
      PageController(viewportFraction: 1);

  double _pageOffset = 0;

  final List<OnboardingPage> _pages = const [
    OnboardingPage(
      image: "assets/Koto1.png",
      title: "Swipe to Like or Dislike",
      subtitle:
          "Swipe left to dislike\nor right to like cats.",
    ),
    OnboardingPage(
      image: "assets/Koto2.png",
      title: "View Breed Details",
      subtitle:
          "Learn more about each\ncat's breed in detail.",
    ),
    OnboardingPage(
      image: "assets/Koto3.png",
      title: "Explore More Breeds",
      subtitle:
          "Easily browse through\nthe list of different cat breeds.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _pageOffset = _controller.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewModel>();
    final currentPage =
        _pageOffset.round().clamp(0, _pages.length - 1);

    return Scaffold(
      body: Stack(
        children: [
          const Background(),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32),
                  child: AnimatedSwitcher(
                    duration:
                        const Duration(milliseconds: 300),
                    child: Text(
                      _pages[currentPage].title,
                      key: ValueKey(
                          _pages[currentPage].title),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: OnboardingPager(
                    controller: _controller,
                    pageOffset: _pageOffset,
                    pages: _pages,
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40),
                  child: AnimatedSwitcher(
                    duration:
                        const Duration(milliseconds: 300),
                    child: Text(
                      _pages[currentPage].subtitle,
                      key: ValueKey(
                          _pages[currentPage].subtitle),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Indicators(
                  length: _pages.length,
                  currentPage: currentPage,
                ),

                const SizedBox(height: 24),

                BottomButtons(
                  currentPage: currentPage,
                  pagesLength: _pages.length,
                  controller: _controller,
                  onFinish: auth.completeOnboarding,
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}