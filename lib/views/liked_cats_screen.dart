import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../viewmodels/cat_viewmodel.dart';
import '../widgets/breed_stat_widget.dart';

class LikedCatsScreen extends StatelessWidget {
  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CatViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Liked Cats ❤️",
          style: TextStyle(
            color: Color(0xFF4FD5D0),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF9F5FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4FD5D0)),
      ),
      body: vm.likedCats.isEmpty
          ? const Center(
              child: Text(
                "You haven't liked any cats yet.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: vm.likedCats.length,
              itemBuilder: (context, index) {
                final cat = vm.likedCats[index];
                final breed = cat.fullBreed;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: cat.url,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                breed?.name ?? cat.breedName ?? "No breed",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 8),

                              if (breed != null)
                                Text(
                                  "Country: ${breed.origin}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),

                              if (breed != null)
                                Text(
                                  "Temperament: ${breed.temperament}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),

                              if (breed != null)
                                Text(
                                  "Lives: ${breed.lifeSpan} years",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),

                              const SizedBox(height: 8),

                              if (breed != null)
                                Row(
                                  children: [
                                    BreedStatWidget(
                                      icon: "👶",
                                      value: breed.childFriendly,
                                    ),
                                    const SizedBox(width: 8),
                                    BreedStatWidget(
                                      icon: "🐶",
                                      value: breed.dogFriendly,
                                    ),
                                    const SizedBox(width: 8),
                                    BreedStatWidget(
                                      icon: "⚡️",
                                      value: breed.energyLevel,
                                    ),
                                  ],
                                ),

                              const SizedBox(height: 8),

                              if (breed != null)
                                Text(
                                  breed.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
