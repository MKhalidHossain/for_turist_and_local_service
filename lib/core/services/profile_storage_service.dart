import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorageService {
  Future<void> saveField(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  Future<Map<String, dynamic>> collectData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "firstName": prefs.getString("firstName"),
      "lastName": prefs.getString("lastName"),
      "gender": prefs.getString("gender"),
      "age": prefs.getInt("age"),
      "description": prefs.getString("description"),
      "nationality": prefs.getString("nationality"),
      "profileImage": prefs.getString("profileImage"),
      "languages": prefs.getStringList("languages") ?? [],
    };
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("firstName");
    await prefs.remove("lastName");
    await prefs.remove("gender");
    await prefs.remove("age");
    await prefs.remove("description");
    await prefs.remove("nationality");
    await prefs.remove("profileImage");
    await prefs.remove("languages");
  }
}
