class ApiConstants {
  // static const String apiBaseUrl = "http://10.0.2.2:2000/api/v1/";
  static const String apiBaseUrl =
      "https://wheel-n-deal-production.up.railway.app/api/v1/";
  static const String signin = "auth/signin";
  static const String signup = "auth/signup";
  static const String getUserProfile = "user/get-normal-user-porfile";
  static const String sendOTP = "OTP/send-otp";
  static const String validateOTP = "OTP/validate-otp";
  static const String forgotPassword = "OTP/forget-password";
  static const String updateProfile = "user/update";
  static const String postOrder = "user/create-update";
  static const String getAllUserOrders = "user/findAll/{userId}";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
