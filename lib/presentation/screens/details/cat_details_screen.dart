import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../domain/entities/cat.dart';

class CatDetailsScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailsScreen({
    super.key,
    required this.cat,
  });

  @override
  Widget build(BuildContext context) {
    final breed = cat.breedName;
    final fullBreed = cat.fullBreed;
    final heroTag = 'cat_hero_${cat.id}';

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
        iconTheme:
            const IconThemeData(color: Color(0xFF4FD5D0)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: heroTag,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(16),
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: CachedNetworkImage(
                        imageUrl: cat.url,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            const _ShimmerBox(
                          width: 160,
                          height: 160,
                          radius: 16,
                        ),
                        errorWidget: (_, __, ___) =>
                            Container(
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                        ),

                        const SizedBox(height: 12),

                        Text(
                            "Lifespan: ${fullBreed.lifeSpan} years"),
                        Text(
                            "Child friendly: ${fullBreed.childFriendly}/5"),
                        Text(
                            "Dog friendly: ${fullBreed.dogFriendly}/5"),
                        Text(
                            "Energy: ${fullBreed.energyLevel}/5"),
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
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
                        backgroundColor:
                            Colors.pink.shade50,
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 25),

              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                fullBreed.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
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

class _ShimmerState extends State<_Shimmer>
    with SingleTickerProviderStateMixin {
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