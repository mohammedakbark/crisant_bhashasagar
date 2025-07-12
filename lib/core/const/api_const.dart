class ApiConst {
  static const baseUrl = "https://bbs.crisant.com/";

  static const login = "api/profile/userLogin";
  static const register = "api/profile/userregister";
  static const regVerifyOTP = "api/profile/userRegisterOTPVerify";
  static const regResendOTP = "api/profile/userRegisterOTPResend";

  static const forgetPassword = "api/profile/forgotPassword";
  static const forgetPasswordVerify = "api/profile/forgotVerifyOTP";
  static const foregetPasswordResend = "api/profile/forgotOTPResend";

  static const resetPassword = "api/profile/setNewPassword";
  static const userProfile = "api/profile/userProfile";

  static const getUiLang = "api/masters/uiLanguages";
  static const setUiLangugae = "api/profile/customerUIPreference";

  static const getInstruction = "api/masters/instructions";
}
