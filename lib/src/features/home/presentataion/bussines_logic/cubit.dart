import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/features/home/domain/use_case/use_case.dart';
import 'package:tabark_innov8/src/features/home/presentataion/bussines_logic/state.dart';

import '../../domain/model/model.dart';

class CheckInCheckOutCubit extends Cubit<CheckInCheckOutState> {
  final CheckInUseCase checkInUseCase;
  final CheckOutUseCase checkOutUseCase;
  final EnableNotificationUseCase enableNotificationUseCase;

  CheckInCheckOutCubit({
    required this.checkInUseCase,
    required this.checkOutUseCase,
    required this.enableNotificationUseCase,
  }) : super(InitialState());

  Future<void> checkIn(LocationData data) async {
    emit(LoadingState());
    try {
      await checkInUseCase.checkIn(data);
      emit(CheckInSuccessState());
    } catch (e) {
      emit(CheckInFailureState(e.toString()));
    }
  }

  Future<void> checkOut(LocationData data) async {
    emit(LoadingState());
    try {
      await checkOutUseCase.checkOut(data);
      emit(CheckOutSuccessState());
    } catch (e) {
      emit(CheckOutFailureState(e.toString()));
    }
  }

  Future<void> enableNotification(bool enable) async {
    emit(LoadingState());
    try {
      await enableNotificationUseCase.enableNotification(enable);
      emit(EnableNotificationSuccessState());
    } catch (e) {
      emit(EnableNotificationFailureState(e.toString()));
    }
  }
}
