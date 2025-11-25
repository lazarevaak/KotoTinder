import 'package:flutter/material.dart';

class SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  const SwipeCard({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double posX = 0;
  double posY = 0;
  double angle = 0;

  bool isSwiping = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_isDisposed) {
        setState(() {
          posX = 0;
          posY = 0;
          angle = 0;
          isSwiping = false;
        });

        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;

    if (_controller.isAnimating) {
      _controller.stop();
    }

    _controller.dispose();
    super.dispose();
  }

  void resetCard() {
    setState(() {
      posX = 0;
      posY = 0;
      angle = 0;
      isSwiping = false;
    });
  }

  void animateCardOffscreen(bool right) {
    setState(() {
      posX = right ? 500 : -500;
      angle = right ? 0.4 : -0.4;
      isSwiping = true;
    });

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 350), () {
      if (!_isDisposed) {
        if (right) {
          widget.onSwipeRight();
        } else {
          widget.onSwipeLeft();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double power = (posX.abs() / 120).clamp(0, 1);

    final Color borderColor = posX > 0
        ? Colors.pinkAccent
        : const Color(0xFF4FD5D0);

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          posX += details.delta.dx;
          posY += details.delta.dy;
          angle = posX / 300;
        });
      },
      onPanEnd: (_) {
        const swipeThreshold = 120;

        if (posX > swipeThreshold) {
          animateCardOffscreen(true);
        } else if (posX < -swipeThreshold) {
          animateCardOffscreen(false);
        } else {
          resetCard();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Transform.translate(
            offset: Offset(posX, posY),
            child: Transform.rotate(
              angle: angle,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSwiping ? 0.3 : 1,
                child: Container(
                  width: 330,
                  height: 430,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),

                    boxShadow: [
                      if (posX != 0)
                        BoxShadow(
                          color: borderColor.withValues(alpha: (power * 0.7)),
                          blurRadius: 40 * power,
                          spreadRadius: 8 * power,
                        ),
                    ],

                    border: Border.all(
                      color: posX == 0
                          ? Colors.transparent
                          : borderColor.withValues(alpha: 0.9),
                      width: power * 6,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: Container(color: Colors.white, child: widget.child),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
