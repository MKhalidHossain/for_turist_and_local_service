import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/feature/profile/domain/model/get_profile_response_model.dart';
import '../domain/model/update_profile_response_model.dart';
import '../services/profile_service_interface.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileServiceInterface profileServiceInterface;

  ProfileController({required this.profileServiceInterface});

  late GetProfileResponseModel getProfileResponseModel;
  late UpdateProfileResponseModel updateProfileResponseModel;

  bool isLoading = false;
  XFile? _pickedProfileFile;
  XFile? get pickedProfileFile => _pickedProfileFile;

  void pickProfileImage() async {
    _pickedProfileFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
        getProfileResponseModel = GetProfileResponseModel.fromJson(response.body);
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

  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required int age,
    required String gender,
    required String nationality,
    required String description,
    List<String>? languages,
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
        updateProfileResponseModel =
            UpdateProfileResponseModel.fromJson(response.body);
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
}
