import 'package:flutter/material.dart';

import '../../../../domain/entities/onboarding_page.dart';

class OnboardingPager extends StatelessWidget {
    const OnboardingPager({
    required this.controller,
    required this.pageOffset,
    required this.pages,
  });

  final PageController controller;
  final double pageOffset;
  final List<OnboardingPage> pages;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      itemCount: pages.length,
      itemBuilder: (_, index) {
        final delta = index - pageOffset;

        final scale =
            (1 - delta.abs() * 0.2).clamp(0.8, 1.0);

        final translateX = delta * 60;
        final rotation = delta * 0.06;

        return Transform.translate(
          offset: Offset(translateX, 0),
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(
              scale: scale,
              child: Center(
                child: SizedBox(
                  height:
                      MediaQuery.of(context).size.height *
                          0.55,
                  child: Image.asset(
                    pages[index].image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}