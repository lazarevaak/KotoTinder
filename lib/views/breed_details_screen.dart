import 'package:flutter/material.dart';
import '../models/breed.dart';

class BreedDetailsScreen extends StatelessWidget {
  final Breed breed;

  const BreedDetailsScreen({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Text(
              breed.name,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Происхождение: ${breed.origin}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Темперамент",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: breed.temperament
                  .split(", ")
                  .map(
                    (t) => Chip(
                      label: Text(t),
                      backgroundColor: Colors.pink.shade50,
                      labelStyle: const TextStyle(fontSize: 14),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 25),

            // DESCRIPTION
            Text(
              "Описание",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              breed.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 25),

            // LIFE SPAN
            Text(
              "Продолжительность жизни: ${breed.lifeSpan} лет",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 25),

            // SKILL BARS (пример)
            _buildStat("Дружелюбность к детям", breed.childFriendly),
            _buildStat("Дружелюбность к собакам", breed.dogFriendly),
            _buildStat("Энергия", breed.energyLevel),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String title, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          "$title: $value/5",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 6),

        // простой бар
        LinearProgressIndicator(
          value: value / 5,
          backgroundColor: Colors.grey.shade300,
          color: Colors.pink.shade300,
          minHeight: 8,
        ),
      ],
    );
  }
}
