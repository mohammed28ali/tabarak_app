import 'package:tabark_innov8/src/features/authentication/forget_password/domain/repository/repository.dart';

import '../../data/model/model.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<void> call(ForgetPasswordModel model) async {
    return await repository.forgetPassword(model);
  }
}

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<void> call(VerifyOtpModel model) async {
    return await repository.verifyOtp(model);
  }
}
