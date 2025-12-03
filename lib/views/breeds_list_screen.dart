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
      child: const Scaffold(
        backgroundColor: Color(0xFFF6F6FA),
        body: _BreedsBody(),
      ),
    );
  }
}

class _BreedsBody extends StatelessWidget {
  const _BreedsBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BreedsViewModel>();

    if (vm.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(
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
              onPressed: vm.loadBreeds,
              child: const Text("Повторить"),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 60),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 237, 211, 236),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onChanged: vm.search,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search breeds...",
                icon: Icon(Icons.search_rounded, color: Colors.grey),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: vm.filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final b = vm.filtered[i];

              return _BreedItem(
                title: b.name,
                subtitle: b.origin,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BreedDetailsScreen(breed: b),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BreedItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BreedItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<_BreedItem> createState() => _BreedItemState();
}

class _BreedItemState extends State<_BreedItem> {
  double _scale = 1.0;

  void _pressDown() => setState(() => _scale = 0.97);
  void _pressUp() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressDown(),
      onTapUp: (_) => _pressUp(),
      onTapCancel: _pressUp,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 237, 211, 236),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  widget.title[0],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                size: 28,
                color: Color(0xFF777777),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
