import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../viewmodels/cat_viewmodel.dart';
import '../widgets/swipe_card.dart';
import '../views/cat_details_screen.dart';
import '../views/liked_cats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatViewModel>(
      builder: (context, vm, _) {
        if (vm.error != null && vm.currentCat == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    vm.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: vm.loadCat,
                    child: const Text("Repeat"),
                  ),
                ],
              ),
            ),
          );
        }

        if (vm.currentCat == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final cat = vm.currentCat!;

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Expanded(
                  child: SwipeCard(
                    onSwipeLeft: () => vm.loadCat(),
                    onSwipeRight: () {
                      vm.like();
                      vm.loadCat();
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
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  cat.breedName ?? "No breed",
                  style: const TextStyle(fontSize: 22),
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LikedCatsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withValues(alpha: 0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${vm.likedCats.length}",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 60,
                      icon: const Icon(Icons.close, color: Color(0xFF4FD5D0)),
                      onPressed: () => vm.loadCat(),
                    ),
                    const SizedBox(width: 40),
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
          ),
        );
      },
    );
  }
}
