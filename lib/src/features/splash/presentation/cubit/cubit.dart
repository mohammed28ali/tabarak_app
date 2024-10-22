import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/features/splash/domain/usecase/usecase.dart';
import 'package:tabark_innov8/src/features/splash/presentation/cubit/state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LoadDataUseCase loadDataUseCase;

  SplashCubit(this.loadDataUseCase) : super(SplashState.initial);

  Future<void> loadData() async {
    emit(SplashState.loading);
    final result = await loadDataUseCase();
    result.fold(
      (error) => emit(SplashState.error),
      (_) => emit(SplashState.loaded),
    );
  }
}
