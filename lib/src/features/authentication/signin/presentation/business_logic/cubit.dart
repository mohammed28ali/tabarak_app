import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/features/authentication/signin/domain/entity/entity.dart';
import 'package:tabark_innov8/src/features/authentication/signin/domain/use_case/login_usecase.dart';
import 'package:tabark_innov8/src/features/authentication/signin/presentation/business_logic/state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  bool showPassword = false;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(LoginUser user) async {
    emit(LoginLoading());
    try {
      await loginUseCase(user);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  void togglePasswordVisibility() {
    emit(LoginLoading());

    showPassword = !showPassword;
    emit(LoginPasswordVisibilityChanged());
  }
}
