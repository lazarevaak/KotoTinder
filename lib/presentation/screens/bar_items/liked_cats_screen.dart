import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../viewmodels/cat_viewmodel.dart';
import '../../widgets/breed_stat_widget.dart';

import '../details/cat_details_screen.dart';

class LikedCatsScreen extends StatelessWidget {
  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CatViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F5FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4FD5D0)),
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Liked Cats",
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.favorite, color: Colors.pink, size: 26),
          ],
        ),
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

                final heroTag = _heroTagFromId(cat.id);

                return LikedCatCard(
                  cat: cat,
                  breed: breed,
                  heroTag: heroTag,
                  onOpenDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CatDetailsScreen(
                          cat: cat,
                        ),
                      ),
                    );
                  },
                  onRemove: () {
                    vm.remove(cat);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Removed from liked ❤️"),
                        duration: Duration(milliseconds: 700),
                      ),
                    );
                  },

                  catId: (c) => c.id,
                  imageUrl: (c) => c.url,
                  fallbackBreedName: (c) => c.breedName,

                  breedName: (b) => b.name,
                  breedOrigin: (b) => b.origin,
                  breedTemperament: (b) => b.temperament,
                  breedLifeSpan: (b) => b.lifeSpan,
                  breedChildFriendly: (b) => b.childFriendly,
                  breedDogFriendly: (b) => b.dogFriendly,
                  breedEnergyLevel: (b) => b.energyLevel,
                  breedDescription: (b) => b.description,
                );
              },
            ),
    );
  }
}

class LikedCatCard<TCat, TBreed> extends StatelessWidget {
  const LikedCatCard({
    super.key,
    required this.cat,
    required this.breed,
    required this.heroTag,
    required this.onOpenDetails,
    required this.onRemove,

    required this.catId,
    required this.imageUrl,
    required this.fallbackBreedName,

    required this.breedName,
    required this.breedOrigin,
    required this.breedTemperament,
    required this.breedLifeSpan,
    required this.breedChildFriendly,
    required this.breedDogFriendly,
    required this.breedEnergyLevel,
    required this.breedDescription,
  });

  final TCat cat;
  final TBreed? breed;

  final String heroTag;

  final VoidCallback onOpenDetails;
  final VoidCallback onRemove;

  final String Function(TCat cat) catId;
  final String Function(TCat cat) imageUrl;
  final String? Function(TCat cat) fallbackBreedName;

  final String Function(TBreed breed) breedName;
  final String Function(TBreed breed) breedOrigin;
  final String Function(TBreed breed) breedTemperament;
  final String Function(TBreed breed) breedLifeSpan;
  final int Function(TBreed breed) breedChildFriendly;
  final int Function(TBreed breed) breedDogFriendly;
  final int Function(TBreed breed) breedEnergyLevel;
  final String Function(TBreed breed) breedDescription;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(catId(cat)),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        color: Colors.redAccent,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      onDismissed: (_) => onRemove(),
      child: InkWell(
        onTap: onOpenDetails,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CatImage(
                  heroTag: heroTag,
                  url: imageUrl(cat),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CatInfoColumn<TCat, TBreed>(
                    cat: cat,
                    breed: breed,
                    fallbackBreedName: fallbackBreedName,
                    breedName: breedName,
                    breedOrigin: breedOrigin,
                    breedTemperament: breedTemperament,
                    breedLifeSpan: breedLifeSpan,
                    breedChildFriendly: breedChildFriendly,
                    breedDogFriendly: breedDogFriendly,
                    breedEnergyLevel: breedEnergyLevel,
                    breedDescription: breedDescription,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CatImage extends StatelessWidget {
  const _CatImage({
    required this.heroTag,
    required this.url,
  });

  final String heroTag;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: url,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          placeholder: (_, __) => const _ShimmerBox(
            width: 120,
            height: 120,
            radius: 10,
          ),
          errorWidget: (_, __, ___) => Container(
            width: 120,
            height: 120,
            alignment: Alignment.center,
            color: Colors.black12,
            child: const Icon(Icons.broken_image, color: Colors.black45),
          ),
        ),
      ),
    );
  }
}

class _CatInfoColumn<TCat, TBreed> extends StatelessWidget {
  const _CatInfoColumn({
    required this.cat,
    required this.breed,
    required this.fallbackBreedName,

    required this.breedName,
    required this.breedOrigin,
    required this.breedTemperament,
    required this.breedLifeSpan,
    required this.breedChildFriendly,
    required this.breedDogFriendly,
    required this.breedEnergyLevel,
    required this.breedDescription,
  });

  final TCat cat;
  final TBreed? breed;

  final String? Function(TCat cat) fallbackBreedName;

  final String Function(TBreed breed) breedName;
  final String Function(TBreed breed) breedOrigin;
  final String Function(TBreed breed) breedTemperament;
  final String Function(TBreed breed) breedLifeSpan;
  final int Function(TBreed breed) breedChildFriendly;
  final int Function(TBreed breed) breedDogFriendly;
  final int Function(TBreed breed) breedEnergyLevel;
  final String Function(TBreed breed) breedDescription;

  @override
  Widget build(BuildContext context) {
    final b = breed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          b != null ? breedName(b) : (fallbackBreedName(cat) ?? "No breed"),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        if (b != null) ...[
          Text(
            "Country: ${breedOrigin(b)}",
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Text(
            "Temperament: ${breedTemperament(b)}",
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Text(
            "Lives: ${breedLifeSpan(b)} years",
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 8),

          BreedStatWidget(
            icon: Icons.child_care,
            color: const Color(0xFF4FD5D0),
            value: breedChildFriendly(b),
          ),
          const SizedBox(height: 4),
          BreedStatWidget(
            icon: Icons.pets,
            color: const Color(0xFF4FD5D0),
            value: breedDogFriendly(b),
          ),
          const SizedBox(height: 4),
          BreedStatWidget(
            icon: Icons.bolt,
            color: const Color(0xFF4FD5D0),
            value: breedEnergyLevel(b),
          ),
          const SizedBox(height: 8),

          Text(
            breedDescription(b),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ],
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.width,
    required this.height,
    this.radius = 12,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _Shimmer extends StatefulWidget {
  const _Shimmer({required this.child});

  final Widget child;

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const base = Color(0xFFE9E9EE);
    const highlight = Color(0xFFF7F7FA);

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final t = _controller.value;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment(-1.0 - 2.0 * (1 - t), 0),
              end: Alignment(1.0 + 2.0 * t, 0),
              colors: const [base, highlight, base],
              stops: const [0.35, 0.5, 0.65],
            ).createShader(rect);
          },
          child: DecoratedBox(
            decoration: const BoxDecoration(color: base),
            child: widget.child,
          ),
        );
      },
    );
  }
}

String _heroTagFromId(Object id) => 'cat_hero_$id';