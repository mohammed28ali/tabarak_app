import 'package:dio/dio.dart';
import 'package:tabark_innov8/src/core/api/api_factory.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';
import 'package:tabark_innov8/src/features/authentication/signup/data/model/register_user_model.dart';

class RegisterRemoteDataSource {
  final ApiFactory _apiFactory;

  RegisterRemoteDataSource(this._apiFactory);

  Future<void> registerUser(RegisterUserModel registerUserModel) async {
    await _apiFactory.postRequest(
      EndPoints.register,
      data: registerUserModel.toJson(),
      sendAsFormData: true,
    );
  }
}
