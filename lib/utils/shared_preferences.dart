import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  final pref = SharedPreferences.getInstance();
  String? token = '';
  saveToPreference({required String string}) async {
    final prefs = await pref;
    await prefs.setString('token', string);
  }

  loadFromPreference() {}
}
