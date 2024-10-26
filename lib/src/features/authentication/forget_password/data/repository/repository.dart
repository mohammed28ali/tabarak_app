import 'package:tabark_innov8/src/core/api/api_factory.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/data/model/model.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/domain/repository/repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiFactory _apiFactory;

  AuthRepositoryImpl(this._apiFactory);

  @override
  Future<void> forgetPassword(ForgetPasswordModel model) async {
    await _apiFactory.postRequest(EndPoints.forgetPassword,
        data: model.toJson(), sendAsFormData: true);
  }

  @override
  Future<void> verifyOtp(VerifyOtpModel model) async {
    await _apiFactory.postRequest(EndPoints.verifyOtp,
        data: model.toJson(), sendAsFormData: true);
  }
}
