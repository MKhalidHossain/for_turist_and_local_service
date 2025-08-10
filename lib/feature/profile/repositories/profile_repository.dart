import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';

import '../../../helpers/remote/data/api_client.dart';
import 'profile_repository_interface.dart';

class ProfileRepository implements ProfileRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProfileRepository(this.apiClient, this.sharedPreferences);

  @override
  Future<Response> getProfile() async {
    return await apiClient.getData(Urls.getProfile);
  }

  @override
  Future<Response> updateProfile({
    required String firstName,
    required String lastName,
    required int age,
    required String gender,
    required String nationality,
    required String description,
    List<String>? languages,
    required XFile profileImage,
  }) async {
    debugPrint("Updating profile with image: ${profileImage?.path}");

    return await apiClient.patchData(Urls.updateProfile, {
      "firstName": firstName,
      "lastName": lastName,
      "age": age,
      "gender": gender.toLowerCase(),
      "nationality": nationality,
      "languages": languages,
      "description": description,

      "profileImage":
          await profileImage.path, // Convert XFile to bytes if not null
    });
  }

  @override
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await apiClient.postData(Urls.changePassword, {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });
  }
}
