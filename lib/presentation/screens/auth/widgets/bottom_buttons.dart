import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required this.currentPage,
    required this.pagesLength,
    required this.controller,
    required this.onFinish,
  });

  final int currentPage;
  final int pagesLength;
  final PageController controller;
  final Future<void> Function() onFinish;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onFinish,
            child: const Text(
              "SKIP",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor:
                  const Color(0xFF4DAFB4),
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 8,
            ),
            onPressed: () async {
              if (currentPage == pagesLength - 1) {
                await onFinish();
              } else {
                controller.nextPage(
                  duration:
                      const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                );
              }
            },
            child: Text(
              currentPage == pagesLength - 1
                  ? "START"
                  : "NEXT",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
