import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart' as utils;

class GitHubSignInButton extends StatefulWidget {
  GitHubSignInButton({
    Key? key,
  })  : _githubUri = utils.generateGithubUri(),
        super(key: key);

  final Uri _githubUri;

  @override
  State<GitHubSignInButton> createState() => _GitHubSignInButtonState();
}

class _GitHubSignInButtonState extends State<GitHubSignInButton> {
  bool _signingIn = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          onPressed: _signingIn // disable while signing in
              ? null
              : () async {
                  if (await canLaunchUrl(widget._githubUri)) {
                    setState(() {
                      _signingIn = true;
                    });
                    await launchUrl(widget._githubUri);
                  } else {
                    throw "Could not launch ${widget._githubUri}";
                  }
                },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              _signingIn ? 'Signing in...' : 'Sign in with GitHub',
              style: const TextStyle(
                  fontWeight: FontWeight.w400, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Image.asset(
                'assets/github32.png',
                height: 20,
              ),
            )
          ])),
    );
  }
}
