import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    super.key,
    this.title,
    this.message,
    this.icon = Icons.sentiment_dissatisfied,
  });

  final String? title;
  final String? message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            title ?? 'Vide !!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Aucune données trouvés',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

Center emptyData(BuildContext context) {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.sentiment_dissatisfied,
          size: 64,
        ),
        SizedBox(height: 16),
        Text(
          'Vide',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Pas de données trouvés',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
