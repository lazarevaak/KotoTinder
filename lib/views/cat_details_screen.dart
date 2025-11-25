import 'package:flutter/material.dart';
import '../models/cat.dart';

class CatDetailsScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    final breed = cat.breedName;
    final fullBreed = cat.fullBreed;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          breed ?? "Kot",
          style: const TextStyle(
            color: Color(0xFF4FD5D0),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF9F5FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4FD5D0)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Картинка + текст в строке ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // квадратная картинка
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Image.network(cat.url, fit: BoxFit.cover),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        breed ?? "No breed",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (fullBreed != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          "Origin: ${fullBreed.origin}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                          softWrap: true,
                        ),

                        const SizedBox(height: 12),
                        Text("Lifespan: ${fullBreed.lifeSpan} years"),
                        Text("Child friendly: ${fullBreed.childFriendly}/5"),
                        Text("Dog friendly: ${fullBreed.dogFriendly}/5"),
                        Text("Energy: ${fullBreed.energyLevel}/5"),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            if (fullBreed != null) ...[
              const Text(
                "Temperament",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

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

              const SizedBox(height: 25),

              const Text(
                "Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              Text(
                fullBreed.description,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
