import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../models/user_profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;
  String? errorText;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Depth.EI')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: const InputDecoration(hintText: 'Email')),
            const SizedBox(height: 12),
            TextField(controller: passCtrl, decoration: const InputDecoration(hintText: 'Password'), obscureText: true),
            const SizedBox(height: 16),
            if (errorText != null) ...[
              Text(errorText!, style: const TextStyle(color: Colors.redAccent)),
              const SizedBox(height: 8),
            ],
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : () async {
                      setState(() { loading = true; errorText = null; });
                      try {
                        final auth = AuthService();
                        UserCredential cred;
                        try {
                          cred = await auth.signInWithEmail(emailCtrl.text.trim(), passCtrl.text.trim());
                        } catch (_) {
                          cred = await auth.signUpWithEmail(emailCtrl.text.trim(), passCtrl.text.trim());
                        }
                        final user = cred.user!;
                        final profile = UserProfile(
                          uid: user.uid,
                          name: user.displayName ?? '',
                          email: user.email ?? emailCtrl.text.trim(),
                          country: '',
                          currency: 'USD',
                          level: 'Debt Fighter',
                          walletBalance: 0,
                          totalDebt: 0,
                        );
                        await FirestoreService().ensureUserProfile(profile);
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(context, '/setup');
                      } catch (e) {
                        setState(() { errorText = 'Auth failed: $e'; });
                      } finally {
                        setState(() { loading = false; });
                      }
                    },
                    child: Text(loading ? 'Please wait…' : 'Login / Sign Up'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: loading ? null : () async {
                setState(() { loading = true; errorText = null; });
                try {
                  final cred = await AuthService().signInWithGoogle();
                  final user = cred.user!;
                  final profile = UserProfile(
                    uid: user.uid,
                    name: user.displayName ?? '',
                    email: user.email ?? '',
                    country: '',
                    currency: 'USD',
                    level: 'Debt Fighter',
                    walletBalance: 0,
                    totalDebt: 0,
                  );
                  await FirestoreService().ensureUserProfile(profile);
                  if (!mounted) return;
                  Navigator.pushReplacementNamed(context, '/setup');
                } catch (e) {
                  setState(() { errorText = 'Google sign-in failed: $e'; });
                } finally {
                  setState(() { loading = false; });
                }
              },
              child: const Text('Continue with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
