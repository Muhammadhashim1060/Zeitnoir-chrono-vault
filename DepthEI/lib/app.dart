import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'routes.dart';
import 'theme.dart';

class AppState extends ChangeNotifier {
  String? userId;
  String displayName = '';
  String level = 'Debt Fighter';
  num walletBalance = 0;

  void setUser(String? uid) {
    userId = uid;
    notifyListeners();
  }
}

class DepthEIApp extends StatefulWidget {
  const DepthEIApp({super.key});

  @override
  State<DepthEIApp> createState() => _DepthEIAppState();
}

class _DepthEIAppState extends State<DepthEIApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseAuth.instance.authStateChanges().listen((user) {
      // Update AppState when auth changes
      final appState = context.read<AppState>();
      appState.setUser(user?.uid);
    });
    setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator())));
    }

    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Depth.EI',
        theme: DepthTheme.themeDark,
        routerConfig: buildRouter(),
      ),
    );
  }
}
