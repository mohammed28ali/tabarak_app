import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabark_innov8/src/core/api/api_factory.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';
import 'package:tabark_innov8/src/features/authentication/signin/domain/entity/entity.dart';

class LoginRemoteDataSource {
  final ApiFactory apiFactory;

  LoginRemoteDataSource(this.apiFactory);

  Future<void> login(LoginUser user) async {
    final data = {
      'UserName': user.username,
      'Password': user.password,
      'NotificationKey': user.notificationKey,
    };
    final response = await apiFactory.postRequest(
      EndPoints.logIn,
      data: data,
      sendAsFormData: true,
    );

    final apiKey = response.data['APIKey'];
    if (apiKey != null) {
      await _cacheApiKey(apiKey);
    }
  }

  Future<void> _cacheApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('APIKey', apiKey);
  }
}
