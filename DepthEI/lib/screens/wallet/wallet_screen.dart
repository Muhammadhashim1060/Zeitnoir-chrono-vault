import 'package:flutter/material.dart';
import '../../services/flutterwave_service.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet & Subscriptions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Balance: $10.00'),
            const SizedBox(height: 12),
            const Text('Plans'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Starter'),
                          const Text('4 10 / month'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () async {
                              await FlutterwaveService.startSubscription(context: context, plan: 'starter', amountUsd: 10);
                            },
                            child: const Text('Subscribe (Stub)'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Premium'),
                          const Text('4 30 / month'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () async {
                              await FlutterwaveService.startSubscription(context: context, plan: 'premium', amountUsd: 30);
                            },
                            child: const Text('Subscribe (Stub)'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
