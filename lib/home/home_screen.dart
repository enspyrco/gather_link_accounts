import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:gather_link_accounts_flutter/link_accounts_view/link_accounts_view.dart';

import '../link_accounts_view/buttons/sign_out_button.dart';

typedef JsonMap = Map<String, Object?>;

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.user, {Key? key}) : super(key: key);

  final firebase.User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          LinkAccountsView(widget.user),
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
