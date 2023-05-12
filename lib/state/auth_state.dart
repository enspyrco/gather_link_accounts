enum AuthState {
  checking(true),
  notSignedIn(false),
  signingIn(true),
  signedIn(true);

  final bool disable;
  const AuthState(this.disable);
}
