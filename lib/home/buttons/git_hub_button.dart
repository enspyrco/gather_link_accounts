import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../state/linking_state.dart';
import '../../utils/utils.dart' as utils;

class GitHubButton extends StatelessWidget {
  GitHubButton({
    Key? key,
    required this.linkingState,
  })  : _githubUri = utils.generateGithubUri(),
        super(key: key);

  final Uri _githubUri;
  final LinkingState linkingState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          onPressed: linkingState.disabled
              ? null
              : () async {
                  if (await canLaunchUrl(_githubUri)) {
                    await launchUrl(_githubUri);
                  } else {
                    throw "Could not launch $_githubUri";
                  }
                },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '${linkingState.buttonText}GitHub',
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
