import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';

import '../../../domain/entities/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
            colors: [
              Color(0xFF7FD6DB),
              Color(0xFF5FC3C8),
              Color(0xFF4DAFB4),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 32),
                child: AnimatedSwitcher(
                  duration:
                      const Duration(milliseconds: 300),
                  child: Text(
                    _pages[currentPage].title,
                    key: ValueKey(
                        _pages[currentPage].title),
                    textAlign:
                        TextAlign.center,
                    style:
                        const TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _controller,
                      physics:
                          const BouncingScrollPhysics(),
                      itemCount:
                          _pages.length,
                      itemBuilder:
                          (_, index) {
                        final delta =
                            index -
                                _pageOffset;

                        final scale =
                            (1 - delta.abs() * 0.2)
                                .clamp(
                                    0.8,
                                    1.0);

                        final translateX =
                            delta * 60;

                        final rotation =
                            delta * 0.06;

                        return Transform.translate(
                          offset:
                              Offset(
                                  translateX,
                                  0),
                          child:
                              Transform.rotate(
                            angle:
                                rotation,
                            child:
                                Transform.scale(
                              scale:
                                  scale,
                              child:
                                  Center(
                                child:
                                    SizedBox(
                                  height:
                                      MediaQuery.of(
                                                  context)
                                              .size
                                              .height *
                                          0.55,
                                  child:
                                      Image.asset(
                                    _pages[
                                            index]
                                        .image,
                                    fit:
                                        BoxFit
                                            .contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child:
                          IgnorePointer(
                        child:
                            Container(
                          height: 180,
                          decoration:
                              const BoxDecoration(
                            gradient:
                                LinearGradient(
                              begin:
                                  Alignment
                                      .topCenter,
                              end:
                                  Alignment
                                      .bottomCenter,
                              colors: [
                                Colors
                                    .transparent,
                                Color(
                                    0x884DAFB4),
                                Color(
                                    0xFF4DAFB4),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 40),
                child: AnimatedSwitcher(
                  duration:
                      const Duration(milliseconds: 300),
                  child: Text(
                    _pages[currentPage]
                        .subtitle,
                    key: ValueKey(
                        _pages[currentPage]
                            .subtitle),
                    textAlign:
                        TextAlign.center,
                    style:
                        const TextStyle(
                      fontSize: 16,
                      color:
                          Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) {
                    final active =
                        index ==
                            currentPage;
                    return AnimatedContainer(
                      duration:
                          const Duration(
                              milliseconds:
                                  300),
                      margin:
                          const EdgeInsets
                              .all(6),
                      height: 8,
                      width: active
                          ? 24
                          : 8,
                      decoration:
                          BoxDecoration(
                        color: active
                            ? Colors
                                .white
                            : Colors
                                .white38,
                        borderRadius:
                            BorderRadius
                                .circular(
                                    20),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 32),
                child: Row(
                  children: [
                    Flexible(
                      child: TextButton(
                        onPressed: () async {
                          await auth
                              .completeOnboarding();
                        },
                        child: const Text(
                          "SKIP",
                          style:
                              TextStyle(
                            fontSize: 16,
                            color: Colors
                                .white70,
                            fontWeight:
                                FontWeight
                                    .w500,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    Flexible(
                      child: ElevatedButton(
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              Colors.white,
                          foregroundColor:
                              const Color(
                                  0xFF4DAFB4),
                          padding:
                              const EdgeInsets
                                  .symmetric(
                                      horizontal:
                                          28,
                                      vertical:
                                          16),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        40),
                          ),
                          elevation:
                              8,
                        ),
                        onPressed:
                            () async {
                          if (currentPage ==
                              _pages.length -
                                  1) {
                            await auth
                                .completeOnboarding();
                          } else {
                            _controller
                                .nextPage(
                              duration:
                                  const Duration(
                                      milliseconds:
                                          400),
                              curve: Curves
                                  .easeOut,
                            );
                          }
                        },
                        child: Text(
                          currentPage ==
                                  _pages.length -
                                      1
                              ? "START"
                              : "NEXT",
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                            fontSize:
                                16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}