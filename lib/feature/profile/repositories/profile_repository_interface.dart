import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileRepositoryInterface {
  Future<Response> getProfile();
/*************  ✨ Windsurf Command ⭐  *************/
  /// Update user profile information.
  ///
  /// [firstName] is the new first name of the user.
  ///
  /// [lastName] is the new last name of the user.
  ///

/*******  6eca117e-2fcd-4300-9d7c-8ed453ba022f  *******/
  Future<Response> updateProfile({
    required String firstName,
    required String lastName,
    required int age,
    required String gender,
    required String nationality,
    required String description,
    List<String>? languages,
    required XFile profileImage,
  });
    Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
