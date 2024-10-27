import 'dart:developer';

import 'package:tabark_innov8/src/core/api/api_factory.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';

import '../model/model.dart';

class MissionRepository {
  final ApiFactory apiFactory;

  MissionRepository(this.apiFactory);

  Future<List<MissionType>> getMissionTypes() async {
    final response = await apiFactory.getRequest(EndPoints.missionTypes);
    final missionTypes = (response.data as List)
        .map((item) => MissionType.fromJson(item))
        .toList();

    log('Fetched Mission Types: $missionTypes');
    return missionTypes;
  }

  Future<void> addMission(Mission mission) async {
    await apiFactory.postRequest(EndPoints.addMission,
        data: mission.toJson(), sendAsFormData: true);
  }
}
