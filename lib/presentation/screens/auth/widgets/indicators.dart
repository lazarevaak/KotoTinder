import 'package:flutter/material.dart';

class Indicators extends StatelessWidget {
  const Indicators({
    super.key,
    required this.length,
    required this.currentPage,
  });

  final int length;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final active = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(6),
          height: 8,
          width: active ? 24 : 8,
          decoration: BoxDecoration(
            color:
                active ? Colors.white : Colors.white38,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}
