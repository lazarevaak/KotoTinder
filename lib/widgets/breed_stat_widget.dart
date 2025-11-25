import 'package:flutter/material.dart';

class BreedStatWidget extends StatelessWidget {
  final String icon;
  final int value;

  const BreedStatWidget({super.key, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Row(
          children: List.generate(
            5,
            (i) => Icon(
              i < value ? Icons.circle : Icons.circle_outlined,
              size: 10,
              color: i < value ? Colors.pinkAccent : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
