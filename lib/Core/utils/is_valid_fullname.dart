bool isValidFullName(String fullName) {
  // Check for null or empty string
  if (fullName.isEmpty) {
    return false;
  }

  // Check for valid characters (letters, spaces, and hyphens)
  RegExp nameRegExp = RegExp(r'^[a-zA-Z\s\-]+$');
  if (!nameRegExp.hasMatch(fullName)) {
    return false;
  }

  // Split the full name into words
  List<String> nameParts = fullName.trim().split(' ');

  // Check for a minimum number of name parts (adjust as needed)
  if (nameParts.length < 2) {
    return false; // Assuming a valid full name has at least a first and last name
  }

  // Check the length of each part (customize as needed)
  for (String part in nameParts) {
    if (part.length < 2) {
      return false;
    }
  }

  return true;
}
