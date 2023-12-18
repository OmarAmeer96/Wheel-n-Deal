bool isValidFullName(String fullName) {
  // Check for null or empty string
  if (fullName.isEmpty) {
    return false;
  }

  RegExp nameRegExp = RegExp(r'^[a-zA-Z\s\-]+$');
  if (!nameRegExp.hasMatch(fullName)) {
    return false;
  }

  List<String> nameParts = fullName.trim().split(' ');

  if (nameParts.length < 2) {
    return false;
  }

  for (String part in nameParts) {
    if (part.length < 2) {
      return false;
    }
  }

  return true;
}
