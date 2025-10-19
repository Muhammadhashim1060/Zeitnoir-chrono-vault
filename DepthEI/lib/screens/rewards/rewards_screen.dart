import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = const ['Debt Fighter', 'Money Soldier', 'Freedom Master'];
    return Scaffold(
      appBar: AppBar(title: const Text('Rewards & Levels')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: levels.length,
        itemBuilder: (ctx, i) {
          return Card(
            child: ListTile(
              title: Text(levels[i]),
              subtitle: const Text('Earn XP by completing daily challenges.'),
            ),
          );
        },
      ),
    );
  }
}
