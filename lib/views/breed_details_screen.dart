import 'package:flutter/material.dart';
import '../models/breed.dart';

class BreedDetailsScreen extends StatelessWidget {
  final Breed breed;

  const BreedDetailsScreen({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(breed.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Происхождение: ${breed.origin}"),
            const SizedBox(height: 10),
            Text("Темперамент: ${breed.temperament}"),
            const SizedBox(height: 10),
            Text(breed.description),
          ],
        ),
      ),
    );
  }
}
