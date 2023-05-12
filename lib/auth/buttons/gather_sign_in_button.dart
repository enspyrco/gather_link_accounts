import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GatherSignInButton extends StatelessWidget {
  const GatherSignInButton(
    this.gatherUri, {
    Key? key,
  }) : super(key: key);

  final Uri gatherUri;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunchUrl(gatherUri)) {
            await launchUrl(gatherUri);
          } else {
            throw 'Could not launch $gatherUri';
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
