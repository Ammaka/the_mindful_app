//shared preferences is used in this class to ui remember the name and the image of the user
import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  static const KeyName = "name";
  static const KeyImage = "image";

  Future<bool> setSettings(String name, String image) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString(KeyName, name);
      await sp.setString(KeyImage, image);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<Map<String, String>> getSettings() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String name = sp.getString(KeyName) ?? "";
    final String image = sp.getString(KeyImage) ?? "";
    try {
      return {KeyName: name, KeyImage: image};
    } on Exception catch (_) {
      return {};
    }
  }
}
