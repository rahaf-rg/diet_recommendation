
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user_profile.dart';

class ProfileStorage {
  static const String _profileKey = 'saved_user_profile';

  static Future<void> saveProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_profileKey, profile.toJsonString());
  }

  static Future<UserProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(_profileKey);

    if (savedData == null) return null;

    return UserProfile.fromJsonString(savedData);
  }

  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profileKey);
  }
}
