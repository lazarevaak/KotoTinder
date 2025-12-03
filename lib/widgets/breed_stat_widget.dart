import 'package:flutter/material.dart';

class BreedStatWidget extends StatelessWidget {
  final IconData icon;
  final int value;
  final Color color;

  const BreedStatWidget({
    super.key,
    required this.icon,
    required this.value,
    this.color = const Color(0xFF4FD5D0),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 26),

        const SizedBox(width: 8),

        Row(
          children: List.generate(5, (i) {
            final bool filled = i < value;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                filled ? Icons.circle : Icons.circle_outlined,
                size: 10,
                color: filled ? Colors.pink : Colors.grey.shade300,
              ),
            );
          }),
        ),
      ],
    );
  }
}
