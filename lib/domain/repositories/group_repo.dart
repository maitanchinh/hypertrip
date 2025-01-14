import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hypertrip/domain/models/group/assign_group_response.dart';
import 'package:hypertrip/domain/models/group/group.dart';
import 'package:hypertrip/domain/models/user/member.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';

import 'user_repo.dart';

class GroupRepo {
  final Dio apiClient = getIt.get<Dio>();

  GroupRepo();

  Future<Group?> getCurrentGroup() async {
    try {
      var id = UserRepo.profile!.id;
      // var id = "21751a9c-fcd9-4fcc-93ed-7a4349a34bc7";
      var res = await apiClient.get("/users/$id/current-group");

      return Group.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        throw Exception(msg_server_error);
      }
    }
  }

  Future<List<Member>> getMembers(String? groupId) async {
    if (groupId == null) return [];

    try {
      var res = await apiClient.get("/tour-groups/$groupId/members");
      var rs = (res.data as List).map((e) => Member.fromJson(e)).toList();
      return rs;
    } on DioException catch (_) {
      return [];
    }
  }

  Future<AssignGroupResponse> getAllCurrentGroups(String id) async {
    try {
      final response = await apiClient.get('/users/${id}/current-group');
      return response.data != null
          ? AssignGroupResponse.fromJson(response.data)
          : AssignGroupResponse();
    } catch (ex) {
      return AssignGroupResponse();
    }
  }

  Future<List<AssignGroupResponse>> getAllJoinedGroups(String id) async {
    try {
      final response = await apiClient.get('/travelers/${id}/joined-groups');
      return response.data != null
          ? (response.data as List<dynamic>)
              .map((assignGroupResponse) => AssignGroupResponse.fromJson(assignGroupResponse))
              .toList()
          : [];
    } catch (ex) {
      return [];
    }
  }

  Future<dynamic> sendEmergency(Position position, String id) async {
    try {
      final response = await apiClient.post('/tour-groups/$id/emergency',
          data: {'longitude': position.longitude, 'latitude': position.latitude});
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<dynamic> endCurrentTourGroup(String id) async {
    try {
      final response = await apiClient.put('/tour-groups/$id/end');
      return true;
    } catch (ex) {
      return false;
    }
  }
}
