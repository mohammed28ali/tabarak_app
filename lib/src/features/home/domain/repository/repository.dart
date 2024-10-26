import '../model/model.dart';

abstract class Repository {
  Future<void> checkIn(LocationData data);
  Future<void> checkOut(LocationData data);
  Future<void> enableNotification(bool enable);
}
