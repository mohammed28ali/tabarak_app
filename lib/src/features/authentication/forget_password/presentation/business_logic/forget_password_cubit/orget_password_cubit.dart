import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/data/model/model.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/domain/usecase/usecase.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/presentation/business_logic/forget_password_cubit/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  ForgetPasswordCubit(this.forgetPasswordUseCase)
      : super(ForgetPasswordInitial());

  Future<void> forgetPassword(String userName) async {
    emit(ForgetPasswordLoading());
    try {
      final model = ForgetPasswordModel(userName: userName);
      await forgetPasswordUseCase.call(model);
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordError(e.toString()));
    }
  }
}
