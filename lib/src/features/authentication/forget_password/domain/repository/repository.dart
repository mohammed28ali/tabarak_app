import '../../data/model/model.dart';

abstract class AuthRepository {
  Future<void> forgetPassword(ForgetPasswordModel model);
  Future<void> verifyOtp(VerifyOtpModel model);
}
