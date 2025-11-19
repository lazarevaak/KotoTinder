import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/breeds_viewmodel.dart';
import 'breed_details_screen.dart';

class BreedsListScreen extends StatelessWidget {
  const BreedsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BreedsViewModel()..loadBreeds(),
      child: Consumer<BreedsViewModel>(
        builder: (context, vm, _) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: vm.breeds.length,
            itemBuilder: (_, i) {
              final b = vm.breeds[i];

              return ListTile(
                title: Text(b.name),
                subtitle: Text(b.origin),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BreedDetailsScreen(breed: b),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
