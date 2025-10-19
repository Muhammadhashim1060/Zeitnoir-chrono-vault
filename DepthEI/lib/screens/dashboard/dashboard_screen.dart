import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Depth.EI')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Total Debt', style: TextStyle(fontSize: 16, color: Colors.white70)),
                  SizedBox(height: 8),
                  Text(' 250.00', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Progress', style: TextStyle(fontSize: 16, color: Colors.white70)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(color: const Color(0xFF00FFB7), value: 30, title: '30%'),
                          PieChartSectionData(color: const Color(0xFF1F1F1F), value: 70, title: '70%'),
                        ],
                        sectionsSpace: 0,
                        centerSpaceRadius: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('Challenge of the Day'),
              subtitle: const Text('Skip eating out today and put $10 towards debt.'),
              trailing: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/coach'),
                child: const Text('Ask Coach'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('Debts'),
              subtitle: const Text('Manage and prioritize your debts.'),
              trailing: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/debts'),
                child: const Text('Open'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/wallet'),
                  child: const Text('Wallet & Subscriptions'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/rewards'),
                  child: const Text('Rewards & Levels'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
