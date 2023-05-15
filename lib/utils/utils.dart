import 'dart:convert';
import 'dart:math';

import 'constants.dart' as constant;
import 'globals.dart' as global;

// From: https://www.scottbrady91.com/dart/generating-a-crypto-random-string-in-dart
class Utils {
  static final Random _random = Random.secure();

  static String generateNonce([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }
}

// Construct a redirect with the nonce and use to generate the gather sign in URI
Uri generateGatherUri() {
  final gatherRedirect = Uri.encodeComponent(
      '${constant.ourServerUrl}/gather/?nonce=${global.gatherNonce}&');
  return Uri.parse('${constant.gatherLinkIdUrl}$gatherRedirect');
}

// Construct a redirect with the nonce and use to generate the github sign in URI
Uri generateGithubUri() {
  return Uri.parse(
      '${constant.githubAuthorizationUrl}&state=${global.githubNonce}');
}
