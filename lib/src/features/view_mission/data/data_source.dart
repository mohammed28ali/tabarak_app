import 'package:dio/dio.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';
import 'package:tabark_innov8/src/features/view_mission/data/view_mission_model.dart';

import '../../../core/api/api_factory.dart';

class MissionDataSource {
  final ApiFactory apiFactory;

  MissionDataSource(this.apiFactory);

  Future<List<MissionsListModel>> getMissions(int pageNumber) async {
    final response = await apiFactory
        .getRequest(EndPoints.missionList, params: {'PageNumber': pageNumber});
    List missionsData = response.data['Data'];
    return missionsData
        .map((json) => MissionsListModel.fromJson(json))
        .toList();
  }

  Future<void> missionCheck(
      String endpoint, MissionCheckModel missionCheck) async {
    final formData = ({
      'MissionId': missionCheck.missionId,
      'Latitude': missionCheck.latitude,
      'Longitude': missionCheck.longitude,
      'UDID': missionCheck.udid,
      'Photo': await MultipartFile.fromFile(missionCheck.photo!.path),
    });

    await apiFactory.postRequest(endpoint,
        data: formData, sendAsFormData: true);
  }
}
