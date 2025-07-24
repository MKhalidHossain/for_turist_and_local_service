
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import '../repositories/profile_repository_interface.dart';
import 'profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface {
  final ProfileRepositoryInterface profileRepositoryInterface;

  ProfileService( {required this.profileRepositoryInterface});



   @override
  Future<Response> getProfile() async {
    return await profileRepositoryInterface.getProfile();
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
    return await profileRepositoryInterface.updateProfile(
      firstName: firstName,
      lastName: lastName,
      age: age,
      gender: gender,
      nationality: nationality,
      description: description,
      languages: languages,
      profileImage: profileImage,
    );
  }

}
