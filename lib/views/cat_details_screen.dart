import 'package:flutter/material.dart';
import '../models/cat.dart';

class CatDetailsScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    final breed = cat.breedName;
    final fullBreed = cat.fullBreed; // добавим это в модель Cat

    return Scaffold(
      appBar: AppBar(
        title: Text(breed ?? "Котик"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: cat.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  cat.url,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              breed ?? "Без породы",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (fullBreed != null) ...[
              const SizedBox(height: 10),
              Text(
                "Происхождение: ${fullBreed.origin}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 15),

              // Темперамент чипами
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: fullBreed.temperament
                    .split(", ")
                    .map(
                      (t) => Chip(
                        label: Text(t),
                        backgroundColor: Colors.pink.shade50,
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 20),

              Text(
                fullBreed.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Продолжительность жизни: ${fullBreed.lifeSpan} лет",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              // Уровни
              Text(
                "Дружелюбность к детям: ${fullBreed.childFriendly}/5",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Дружелюбность к собакам: ${fullBreed.dogFriendly}/5",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Энергия: ${fullBreed.energyLevel}/5",
                style: const TextStyle(fontSize: 16),
              ),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
