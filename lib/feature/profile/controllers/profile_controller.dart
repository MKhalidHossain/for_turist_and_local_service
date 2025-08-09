import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/core/constants/urls.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/change_password_screen.dart';
import 'package:kobeur/feature/profile/domain/model/get_profile_response_model.dart';
import '../../../helpers/remote/data/api_client.dart';
import '../domain/model/update_profile_response_model.dart';
import '../services/profile_service_interface.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController implements GetxService {
  // ProfileController() {
  //   print("i am a constatore");
  //   getApicall();
  // }
  final ProfileServiceInterface profileServiceInterface;

  ProfileController(this.profileServiceInterface);

  late GetProfileResponseModel getProfileResponseModel;
  late UpdateProfileResponseModel updateProfileResponseModel;

  bool isLoading = false;
  XFile? _pickedProfileFile;
  XFile? get pickedProfileFile => _pickedProfileFile;

  XFile identityImage = XFile('');

  List<XFile> identityImages = [];

  List<MultipartBody> multipartList = [];

  // void pickProfileImage() async {
  //   _pickedProfileFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   update();
  // }
  void pickImage(bool isback, bool isProfile) async {
    if (isProfile) {
      _pickedProfileFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        //; source: isback ? ImageSource.camera : ImageSource.gallery,
      );
    } else {
      identityImage =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;

      identityImages.add(identityImage);
      multipartList.add(MultipartBody('identity_images[]', identityImage));
      // _pickedProfileFile = await ImagePicker().pickVideo(
      //   source: isback ? ImageSource.camera : ImageSource.gallery,
      // );
    }
    update();
  }

  void clearPickedImage() {
    _pickedProfileFile = null;
    update();
  }

  Future<void> getUserProfile() async {
    try {
      isLoading = true;
      update();

      final response = await profileServiceInterface.getProfile();
      if (response.statusCode == 200) {
        print("✅ Profile fetched successfully\n");
        getProfileResponseModel = GetProfileResponseModel.fromJson(
          response.body,
        );
        print("✅ Profile fetched successfully\n");
      } else {
        print("❌ Failed to fetch profile: ${response.statusCode}\n");
      }
    } catch (e) {
      print("⚠️ Error fetching profile: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  // onno rokom api call hocche

  // Future<void> getApicall() async {
  //   try {
  //     isLoading = true;
  //     update();
  //     final response = await http.get(Uri.parse('https://kobeur.onrender.com/api/v1/profile'),

  //     headers: {
  //       'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NzI0MmJkYjgxOTZiMjkwZWEyNDE4MCIsImlhdCI6MTc1NDIwMjkyNSwiZXhwIjoxNzU0ODA3NzI1fQ.x2A1bFFiAcqZQNAlqS8yZFKc_fWcp1OK6lfkULpcjXE'
  //     },
  //     );
  //     if (response.statusCode == 200) {
  //       print("✅ Profile fetched successfully\n");

  //       print(response.body);
  //     } else {
  //       print("❌ Failed to fetch profile: ${response.statusCode}\n");
  //     }
  //   } catch (e) {
  //     print("⚠️ Error fetching profile: $e\n");
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }

  // }

  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required int age,
    required String gender,
    required String nationality,
    required String description,
    List<String>? languages,
    XFile? profileImage // Store as a File
  }) async {
    try {
      isLoading = true;
      update();

      final response = await profileServiceInterface.updateProfile(
        firstName: firstName,
        lastName: lastName,
        age: age,
        gender: gender,
        nationality: nationality,
        description: description,
        languages: languages,
        profileImage: _pickedProfileFile,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        updateProfileResponseModel = UpdateProfileResponseModel.fromJson(
          response.body,
        );
        print("✅ Profile updated successfully\n");
      } else {
        print("❌ Failed to update profile: ${response.statusCode}\n");
      }
    } catch (e) {
      print("⚠️ Error updating profile: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> ChangePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isLoading = true;
      update();

      final response = await profileServiceInterface.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        updateProfileResponseModel = UpdateProfileResponseModel.fromJson(
          response.body,
        );
        print("✅ Password changed successfully\n");
      } else {
        print("❌ Failed to changing password: ${response.statusCode}\n");
      }
    } catch (e) {
      print("⚠️ Error changing password: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }
}
