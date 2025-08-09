import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';

import '../../../helpers/remote/data/api_client.dart';
import 'profile_repository_interface.dart';

class ProfileRepository implements ProfileRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProfileRepository( this.apiClient,  this.sharedPreferences);

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
    XFile? profileImage,
  }) async {
    return await apiClient.putData(
      Urls.updateProfile,
      {
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "gender": gender,
        "nationality": nationality,
        "languages": languages,
        "description": description,

        "profileImage": profileImage,
      },
    );
  }
  
  @override
  Future<Response> changePassword({required String currentPassword, required String newPassword, required String confirmPassword}) {
    return apiClient.postData(
      Urls.changePassword,
      {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
    );
  }
}
