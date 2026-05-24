import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalImageStorage {
  static const _key = 'local_profile_image_path';


  static Future<String> saveImage(String sourcePath) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final destPath = '${docsDir.path}/profile_image.jpg';

    final source = File(sourcePath);
    await source.copy(destPath);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, destPath);

    return destPath;
  }

  static Future<String?> getImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_key);
    if (path == null) return null;
    if (!File(path).existsSync()) {
      await prefs.remove(_key);
      return null;
    }
    return path;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_key);
    if (path != null) {
      final file = File(path);
      if (file.existsSync()) await file.delete();
    }
    await prefs.remove(_key);
  }
}
