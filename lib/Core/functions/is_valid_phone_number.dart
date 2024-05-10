// Validate normal phone number
bool isValidPhoneNumber(String phoneNumber) {
  final phoneNumberRegex = RegExp(r'^01[0-2|5]{1}[0-9]{8}$');
  return phoneNumberRegex.hasMatch(phoneNumber);
}

// Validate OTP phone number
bool isValidOTPPhoneNumber(String phoneNumber) {
  final phoneNumberRegex = RegExp(r'^01[0-2|5]{1}[0-9]{8}$');
  return phoneNumberRegex.hasMatch(phoneNumber);
}

// Validate Egyptian phone number with country code
bool isValidEgyptianPhoneNumberWithCountryCode(String phoneNumber) {
  final phoneNumberRegex = RegExp(r'^\+20(15|11|10|12)[0-9]{8}$');
  return phoneNumberRegex.hasMatch(phoneNumber);
}
