import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart' as utils;

class GatherSignInButton extends StatelessWidget {
  GatherSignInButton({Key? key})
      : _gatherUri = utils.generateGatherUri(),
        super(key: key);

  final Uri _gatherUri;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunchUrl(_gatherUri)) {
            await launchUrl(_gatherUri);
          } else {
            throw 'Could not launch $_gatherUri';
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sign In with Gather',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(200, 5, 73, 255)),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Image.asset(
                'assets/gather32.png',
                height: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
