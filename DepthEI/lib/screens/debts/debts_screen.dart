import 'package:flutter/material.dart';

class DebtsScreen extends StatefulWidget {
  const DebtsScreen({super.key});

  @override
  State<DebtsScreen> createState() => _DebtsScreenState();
}

class _DebtsScreenState extends State<DebtsScreen> {
  final debts = <Map<String, dynamic>>[{
    'title': 'Loan from friend',
    'amount': 100.0,
    'due': '2025-11-15',
    'status': 'pending'
  }];

  void _openAddDialog() {
    final titleCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    final dueCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add Debt'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleCtrl, decoration: const InputDecoration(hintText: 'Title')),
              const SizedBox(height: 8),
              TextField(controller: amountCtrl, decoration: const InputDecoration(hintText: 'Amount')),
              const SizedBox(height: 8),
              TextField(controller: dueCtrl, decoration: const InputDecoration(hintText: 'Due date YYYY-MM-DD')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  debts.add({'title': titleCtrl.text, 'amount': double.tryParse(amountCtrl.text) ?? 0, 'due': dueCtrl.text, 'status': 'pending'});
                });
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debts')),
      floatingActionButton: FloatingActionButton(onPressed: _openAddDialog, child: const Icon(Icons.add)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (ctx, i) {
          final d = debts[i];
          return Card(
            child: ListTile(
              title: Text(d['title']),
              subtitle: Text('Amount: ${d['amount']} | Due: ${d['due']} | ${d['status']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => setState(() => debts.removeAt(i)),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: debts.length,
      ),
    );
  }
}
