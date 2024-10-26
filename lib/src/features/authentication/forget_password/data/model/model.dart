class ForgetPasswordModel {
  final String userName;

  ForgetPasswordModel({required this.userName});

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
    };
  }
}

class VerifyOtpModel {
  final String userName;
  final String otp;
  final String password;
  final String confirmPassword;

  VerifyOtpModel({
    required this.userName,
    required this.otp,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'OTP': otp,
      'Password': password,
      'ConfirmPassword': confirmPassword,
    };
  }
}
