import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final nameCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  String currency = 'USD';
  bool loading = false;

  @override
  void dispose() {
    nameCtrl.dispose();
    countryCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    setState(() => loading = true);
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameCtrl.text.trim(),
        'country': countryCtrl.text.trim(),
        'currency': currency,
      }, SetOptions(merge: true));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(hintText: 'Full name')),
            const SizedBox(height: 12),
            TextField(controller: countryCtrl, decoration: const InputDecoration(hintText: 'Country')),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: currency,
              items: const [
                DropdownMenuItem(value: 'USD', child: Text('USD')),
                DropdownMenuItem(value: 'NGN', child: Text('NGN')),
                DropdownMenuItem(value: 'EUR', child: Text('EUR')),
              ],
              onChanged: (v) => setState(() => currency = v ?? 'USD'),
              decoration: const InputDecoration(hintText: 'Currency'),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: loading ? null : _save,
                  child: Text(loading ? 'Please wait…' : 'Save & Continue'),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
