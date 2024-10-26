import 'package:tabark_innov8/src/features/home/domain/model/model.dart';
import 'package:tabark_innov8/src/features/home/domain/repository/repository.dart';

class CheckInUseCase {
  final Repository repository;

  CheckInUseCase(this.repository);

  Future<void> checkIn(LocationData data) async {
    await repository.checkIn(data);
  }
}

class CheckOutUseCase {
  final Repository repository;

  CheckOutUseCase(this.repository);

  Future<void> checkOut(LocationData data) async {
    await repository.checkOut(data);
  }
}

class EnableNotificationUseCase {
  final Repository repository;

  EnableNotificationUseCase(this.repository);

  Future<void> enableNotification(bool enable) async {
    await repository.enableNotification(enable);
  }
}
