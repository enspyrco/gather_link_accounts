import 'package:flutter/material.dart';
import 'package:gather_link_accounts_flutter/auth/buttons/google_sign_in_button.dart';

import '../state/signed_in_state.dart';
import 'buttons/gather_sign_in_button.dart';
import 'buttons/git_hub_sign_in_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen(this.authState, {Key? key}) : super(key: key);

  final SignedInState authState;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool enabled = true;
  Object? error;
  final explanation = 'Welcome to the inNerVeRse!';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: (error == null)
            ? Column(
                children: [
                  const SizedBox(height: 100),
                  if (widget.authState == SignedInState.checking ||
                      widget.authState == SignedInState.signingIn)
                    const CircularProgressIndicator()
                  else ...[
                    GatherSignInButton(),
                    const SizedBox(height: 50),
                    GitHubSignInButton(),
                    const SizedBox(height: 50),
                    const GoogleSignInButton(),
                  ],
                  const SizedBox(height: 50),
                  Text(explanation),
                  const SizedBox(height: 50),
                ],
              )
            : Column(
                children: [const SizedBox(height: 200), Text('$error')],
              ),
      ),
    );
  }
}
