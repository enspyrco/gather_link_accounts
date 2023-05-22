import 'package:flutter/material.dart';
import 'package:gather_link_accounts_flutter/auth/buttons/google_sign_in_button.dart';

import '../state/auth_state.dart';
import 'buttons/gather_sign_in_button.dart';
import 'buttons/git_hub_sign_in_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen(this.authState, {Key? key}) : super(key: key);

  final AuthState authState;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool enabled = true;
  Object? error;
  final explanation =
      'In order to link your Gather account with other accounts such as GitHub,'
      ' we create a section in a database that only this Google account can access.\n\n'
      'Just remember, if you want to unlink accounts or make other changes later'
      ' you’ll need to sign in with the same google account.\n\n'
      'Only public information is stored and can easily be removed on request.';

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
                  if (widget.authState == AuthState.checking ||
                      widget.authState == AuthState.signingIn)
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
