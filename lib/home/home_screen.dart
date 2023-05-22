import 'package:flutter/material.dart';

import '../state/linked_state.dart';
import 'buttons/link_gather_button.dart';
import 'buttons/link_git_hub_button.dart';
import 'buttons/sign_out_button.dart';

typedef JsonMap = Map<String, Object?>;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LinkedState gatherLinkedState = LinkedState.checking;
  LinkedState githubLinkedState = LinkedState.checking;
  final finishedText =
      'Your accounts have been linked!\n\nYou can now close this window and will\n'
      'soon be teleported into the first adventure...';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (githubLinkedState == LinkedState.linked &&
              gatherLinkedState == LinkedState.linked) ...[
            const SizedBox(height: 100),
            Text(finishedText),
          ],
          const SizedBox(height: 100),
          LinkGatherButton(linkingState: gatherLinkedState),
          if (githubLinkedState != LinkedState.linked ||
              gatherLinkedState != LinkedState.linked)
            const SizedBox(height: 100),
          LinkGitHubButton(linkingState: githubLinkedState),
          const SizedBox(height: 150),
          const SizedBox(
              width: 230,
              child: Row(children: [
                SignOutButton(),
                Text('if you would like to start')
              ])),
          const SizedBox(
            width: 300,
            child: Text('             again and use a different account.'),
          )
        ],
      ),
    );
  }
}
