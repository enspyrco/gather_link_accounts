import 'package:flutter/material.dart';

import '../state/linking_state.dart';
import 'buttons/gather_button.dart';
import 'buttons/git_hub_button.dart';
import 'buttons/sign_out_button.dart';

typedef JsonMap = Map<String, Object?>;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LinkingState gatherState = LinkingState.checking;
  LinkingState githubState = LinkingState.checking;
  final finishedText =
      'Your accounts have been linked!\n\nYou can now close this window and will\n'
      'soon be teleported into the first adventure...';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (githubState == LinkingState.linked &&
              gatherState == LinkingState.linked) ...[
            const SizedBox(height: 100),
            Text(finishedText),
          ],
          const SizedBox(height: 100),
          GatherButton(linkingState: gatherState),
          if (githubState != LinkingState.linked ||
              gatherState != LinkingState.linked)
            const SizedBox(height: 100),
          GitHubButton(linkingState: githubState),
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
