import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFBFF4F6),
                Color(0xFF9EE8EC),
                Color(0xFF73D6DB),
                Color(0xFF4DAFB4),
              ],
              stops: [0.0, 0.35, 0.7, 1.0],
            ),
          ),
        ),
        Positioned(
          top: -180,
          left: -120,
          child: IgnorePointer(
            child: Container(
              width: 420,
              height: 420,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x55FFFFFF),
                    Color(0x22FFFFFF),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
