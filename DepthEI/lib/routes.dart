import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/debts/debts_screen.dart';
import 'screens/ai_coach/ai_coach_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/rewards/rewards_screen.dart';
import 'screens/setup/setup_profile_screen.dart';

RouterConfig<Object> buildRouter() {
  return RouterConfig(
    routerDelegate: _RouterDelegate(),
    routeInformationParser: _RouteParser(),
  );
}

class _RouteParser extends RouteInformationParser<RouteSettings> {
  @override
  Future<RouteSettings> parseRouteInformation(RouteInformation routeInformation) async {
    final location = routeInformation.location ?? '/';
    return RouteSettings(name: location);
  }
}

class _RouterDelegate extends RouterDelegate<RouteSettings> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteSettings> {
  RouteSettings _current = const RouteSettings(name: '/');
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navKey;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_current.name) {
      case '/onboarding':
        page = const OnboardingScreen();
        break;
      case '/login':
        page = const LoginScreen();
        break;
      case '/dashboard':
        page = const DashboardScreen();
        break;
      case '/debts':
        page = const DebtsScreen();
        break;
      case '/coach':
        page = const AICoachScreen();
        break;
      case '/wallet':
        page = const WalletScreen();
        break;
      case '/rewards':
        page = const RewardsScreen();
        break;
      case '/setup':
        page = const SetupProfileScreen();
        break;
      case '/':
      default:
        page = const SplashScreen();
    }

    return Navigator(
      key: _navKey,
      pages: [MaterialPage(child: page)],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  @override
  Future<void> setNewRoutePath(RouteSettings configuration) async {
    _current = configuration;
  }
}
