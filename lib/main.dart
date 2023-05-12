import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';
import 'home/home_screen.dart';
import 'auth/auth_screen.dart';
import 'auth/gather_sign_in_screen.dart';
import 'state/auth_state.dart';
import 'utils/utils.dart';

final String gatherNonce = Utils.generateNonce();

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
            return GatherSignInScreen(gatherToken, gatherNonce);
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
  AuthState currentAuthState = AuthState.checking;

  @override
  void initState() {
    super.initState();
    authStateSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!mounted) return;
      setState(() => currentAuthState =
          (user == null) ? AuthState.notSignedIn : AuthState.signedIn);
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
          AuthState.signedIn => const HomeScreen(),
          _ => AuthScreen(currentAuthState, gatherNonce),
        },
      ),
    );
  }
}
