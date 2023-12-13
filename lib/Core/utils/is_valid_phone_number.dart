bool isValidPhoneNumber(String phoneNumber) {
  final phoneNumberRegex = RegExp(r'^01[0-2|5]{1}[0-9]{8}$');
  return phoneNumberRegex.hasMatch(phoneNumber);
}
