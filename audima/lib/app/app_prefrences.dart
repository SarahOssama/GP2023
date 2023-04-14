import 'package:audima/presentaion/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLanguage = "PREFS_KEY_LANGUAGE";
const String prefsKeyHomeScreenViewed = "PREFS_KEY_HOME_SCREEN_VIEWED";
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String prefsKeyBusinessInfoViewed = "PREFS_KEY_BUSINESS_INFO_VIEWED";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLanguage);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  //home screen
  Future<void> setHomeScreenViewed() async {
    await _sharedPreferences.setBool(prefsKeyHomeScreenViewed, true);
  }

  Future<bool> isHomeScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyHomeScreenViewed) ?? false;
  }

  //login screen
  Future<void> setUserLoggedIn() async {
    await _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  //business info screen
  Future<void> setBusinessInfoViewed() async {
    await _sharedPreferences.setBool(prefsKeyBusinessInfoViewed, true);
  }

  Future<void> reSetBusinessInfoViewed() async {
    await _sharedPreferences.setBool(prefsKeyBusinessInfoViewed, false);
  }

  Future<bool> isBusinessInfoViewed() async {
    return _sharedPreferences.getBool(prefsKeyBusinessInfoViewed) ?? false;
  }
}
