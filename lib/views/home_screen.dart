import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';  // ← вот это добавь

import '../viewmodels/cat_viewmodel.dart';
import '../widgets/swipe_card.dart';
import '../views/cat_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CatViewModel()..loadCat(),
      child: Consumer<CatViewModel>(
        builder: (context, vm, _) {
          if (vm.loading || vm.currentCat == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final cat = vm.currentCat!;

          return Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 20),

                // --- Кот со свайпом ---
                Expanded(
                  child: SwipeCard(
                    onSwipeLeft: () => vm.loadCat(),
                    onSwipeRight: () {
                      vm.like();   // увеличиваем лайки
                      vm.loadCat(); // грузим нового кота
                    },
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CatDetailsScreen(cat: cat),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: cat.url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),    
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // --- Имя породы ---
                Text(
                  cat.breedName ?? "Без породы",
                  style: const TextStyle(fontSize: 22),
                ),

                const SizedBox(height: 12),

                // --- Счётчик лайков ---
                Text(
                  "❤️ ${vm.likes}",
                  style: const TextStyle(
                    fontSize: 28,
                    color: Color(0xFFFFB9C6),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black12,
                        blurRadius: 6,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- Кнопки лайк / дизлайк ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // dislike
                    IconButton(
                      iconSize: 60,
                      icon: const Icon(Icons.close, color: Colors.redAccent),
                      onPressed: () => vm.loadCat(),
                    ),
                    const SizedBox(width: 40),

                    // like
                    IconButton(
                      iconSize: 60,
                      icon: const Icon(Icons.favorite, color: Colors.pink),
                      onPressed: () {
                        vm.like();
                        vm.loadCat();
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
