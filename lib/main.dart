import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';
import 'home/home_screen.dart';
import 'auth/auth_screen.dart';
import 'auth/perform_gather_sign_in_screen.dart';
import 'state/signed_in_state.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthGuard();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'gather',
          builder: (BuildContext context, GoRouterState state) {
            final gatherToken = state.queryParameters['token'];
            return PerformGatherSignInScreen(gatherToken);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gather Link Accounts',
      routerConfig: _router,
    );
  }
}

class AuthGuard extends StatefulWidget {
  const AuthGuard({Key? key}) : super(key: key);

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  StreamSubscription<User?>? authStateSubscription;
  SignedInState currentAuthState = SignedInState.checking;

  @override
  void initState() {
    super.initState();
    authStateSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!mounted) return;
      setState(() => currentAuthState =
          (user == null) ? SignedInState.notSignedIn : SignedInState.completed);
    });
  }

  @override
  void dispose() {
    authStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: switch (currentAuthState) {
          SignedInState.completed => const HomeScreen(),
          _ => AuthScreen(currentAuthState),
        },
      ),
    );
  }
}
