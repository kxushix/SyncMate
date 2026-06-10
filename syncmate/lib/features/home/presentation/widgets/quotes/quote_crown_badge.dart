import 'package:flutter/material.dart';

/// A premium top-right badge for featured quote cards.
class QuoteCrownBadge extends StatelessWidget {
  const QuoteCrownBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Color(0xFFFFD301), // Signature Poetistic Yellow
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.workspace_premium,
          size: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
