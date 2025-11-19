import 'package:flutter/material.dart';
import '../models/cat.dart';

class CatDetailsScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cat.breedName ?? "Котик")),
      body: Column(
        children: [
          Image.network(cat.url, height: 300),
          const SizedBox(height: 20),
          Text("Порода: ${cat.breedName ?? "Неизвестно"}"),
          Text("ID: ${cat.id}"),
        ],
      ),
    );
  }
}
