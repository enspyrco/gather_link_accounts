enum SignedInState {
  checking(null),
  notSignedIn(false),
  signingIn(false),
  completed(true);

  final bool? signedIn;
  const SignedInState(this.signedIn);
}
