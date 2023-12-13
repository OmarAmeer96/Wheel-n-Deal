bool isValidUsername(String username) {
  final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,30}$');
  return usernameRegex.hasMatch(username);
}
