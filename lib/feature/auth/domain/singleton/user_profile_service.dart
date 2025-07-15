// services/user_profile_service.dart


import 'user_profile.dart';

class UserProfileService {
  // 1. Private constructor
  UserProfileService._privateConstructor();

  // 2. Static instance
  static final UserProfileService _instance =
      UserProfileService._privateConstructor();

  // 3. Public getter
  static UserProfileService get instance => _instance;

  // 4. Actual user profile data
  final UserProfile profile = UserProfile();
}
