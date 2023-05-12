// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GatherSignInScreen extends StatefulWidget {
  const GatherSignInScreen(this.gatherToken, this.gatherNonce, {Key? key})
      : super(key: key);

  final String? gatherToken;
  final String gatherNonce;

  @override
  State<GatherSignInScreen> createState() => _GatherSignInScreenState();
}

class _GatherSignInScreenState extends State<GatherSignInScreen> {
  bool enabled = true;
  bool finished = false;
  Object? error;
  final finishedText =
      'You have successfully signed in and can now close the window';

  @override
  void initState() {
    super.initState();
    if (widget.gatherToken == null) {
      error = 'No token was found';
    } else {
      signIn(widget.gatherToken!);
    }
  }

  void signIn(String gatherToken) async {
    try {
      await FirebaseAuth.instance.signInWithCustomToken(gatherToken);
      setState(() {
        finished = true;
        window.close();
      });
    } catch (e) {
      setState(() {
        error = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: (finished)
              ? Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(finishedText),
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(height: 200),
                    if (error == null) ...[
                      const CircularProgressIndicator(),
                      const Text('Signing into Firebase with Gather'),
                    ] else if (error is FirebaseAuthException) ...[
                      Text('${(error as FirebaseAuthException).message}')
                    ] else ...[
                      Text('$error')
                    ]
                  ],
                ),
        ),
      ),
    );
  }
}
