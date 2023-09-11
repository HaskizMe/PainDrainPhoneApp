import 'package:shared_preferences/shared_preferences.dart';

class SavedPresets{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setPreferences() async{
    final SharedPreferences prefs = await _prefs;

  }

}