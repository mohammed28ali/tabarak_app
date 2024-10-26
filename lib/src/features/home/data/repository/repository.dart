import 'package:dio/dio.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';
import 'package:tabark_innov8/src/features/home/domain/repository/repository.dart';

import '../../../../core/api/api_factory.dart';
import '../../domain/model/model.dart';

class RepositoryImpl implements Repository {
  final ApiFactory apiFactory;

  RepositoryImpl(this.apiFactory);

  @override
  Future<void> checkIn(LocationData data) async {
    try {
      final formData = {
        'Latitude': data.latitude,
        'Longitude': data.longitude,
        'Photo': await MultipartFile.fromFile(data.photo.path),
        'UDID': data.udid,
      };

      await apiFactory.postRequest(EndPoints.checkin,
          data: formData, sendAsFormData: true);
    } catch (e) {
      throw Exception('Check-in failed: ${e.toString()}');
    }
  }

  @override
  Future<void> checkOut(LocationData data) async {
    try {
      final formData = {
        'Latitude': data.latitude,
        'Longitude': data.longitude,
        'Photo': await MultipartFile.fromFile(data.photo.path),
        'UDID': data.udid,
      };

      await apiFactory.postRequest(EndPoints.checkout,
          data: formData, sendAsFormData: true);
    } catch (e) {
      throw Exception('Check-out failed: ${e.toString()}');
    }
  }

  @override
  Future<void> enableNotification(bool enable) async {
    try {
      await apiFactory.postRequest(EndPoints.enableNotification,
          data: {'Enable': enable}, sendAsFormData: true);
    } catch (e) {
      throw Exception('Enable notification failed: ${e.toString()}');
    }
  }
}
