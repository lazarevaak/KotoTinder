import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            return const Center(child: CircularProgressIndicator());
          }

          final cat = vm.currentCat!;

          return Scaffold(
            appBar: AppBar(title: const Text("KotoTinder")),
            body: Column(
            children: [
              const SizedBox(height: 20),

              Expanded(
                child: Center(
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
                      child: Image.network(
                        cat.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text(
                cat.breedName ?? "Без породы",
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 12),
              Text(
  "❤️ ${vm.likes}",
  style: const TextStyle(
    fontSize: 28,
    color: Color(0xFFFFB9C6), // розовый как лапки
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: Colors.black12,
        blurRadius: 6,
      )
    ],
  ),
)

            ],
          ),

          );
        },
      ),
    );
  }
}
