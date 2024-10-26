import '../../domain/entity/entity.dart';

class RegisterUserModel {
  final String fullName;
  final String userName;
  final String password;

  RegisterUserModel({
    required this.fullName,
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'FullName': fullName,
      'UserName': userName,
      'Password': password,
    };
  }
}
