import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';

import '../state/linked_state.dart';
import 'buttons/link_git_hub_button.dart';

class LinkAccountsView extends StatefulWidget {
  const LinkAccountsView(this.user, {super.key});

  final firebase.User user;

  @override
  State<LinkAccountsView> createState() => _LinkAccountsViewState();
}

class _LinkAccountsViewState extends State<LinkAccountsView> {
  @override
  Widget build(BuildContext context) {
    LinkedState githubLinkedState =
        (widget.user.providerData.any((info) => info.providerId == 'github'))
            ? LinkedState.linked
            : LinkedState.notLinked;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LinkGitHubButton(linkingState: githubLinkedState),
      ],
    );
  }
}
