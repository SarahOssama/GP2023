import 'package:audima/presentaion/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

//general used keys
const String prefsKeyLanguage = "PREFS_KEY_LANGUAGE";
const String prefsKeyHomeScreenViewed = "PREFS_KEY_HOME_SCREEN_VIEWED";
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String prefsKeyBusinessInfoViewed = "PREFS_KEY_BUSINESS_INFO_VIEWED";
//mission statement key
const String prefsKeyMissionStatement = "PREFS_KEY_MISSION_STATEMENT";
//voice over statement key
const String prefsKeyVoiceOverStatement = "PREFS_KEY_VOICEOVER_STATEMENT";
//video key
const String prefsKeyVideoUrl = "PREFS_KEY_VIDEO_URL";
//final video key
const String prefsKeyFinalVideoUrl = "PREFS_KEY_FINAL_VIDEO_URL";

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

  //----------------------------------------------------------------------------mission statement
  //set Business statement
  Future<void> setMissionStatement(String missionStatement) async {
    await _sharedPreferences.setString(
        prefsKeyMissionStatement, missionStatement);
  }

  //set voice over statement
  Future<void> setVoiceOverStatement(String voiceOverStatement) async {
    await _sharedPreferences.setString(
        prefsKeyVoiceOverStatement, voiceOverStatement);
  }

  //get mission statement
  Future<String> getMissionStatement() async {
    String? missionStatement =
        _sharedPreferences.getString(prefsKeyMissionStatement);
    if (missionStatement != null && missionStatement.isNotEmpty) {
      return missionStatement;
    } else {
      return "";
    }
  }

//get voice over statement
  Future<String> getVoiceOverStatement() async {
    String? voiceOverStatement =
        _sharedPreferences.getString(prefsKeyVoiceOverStatement);
    if (voiceOverStatement != null && voiceOverStatement.isNotEmpty) {
      return voiceOverStatement;
    } else {
      return "";
    }
  }

  //----------------------------------------------------------------------------video
  //set video url
  Future<void> setVideoUrl(String videoUrl) async {
    await _sharedPreferences.setString(prefsKeyVideoUrl, videoUrl);
  }

  //get video url
  Future<String> getVideoUrl() async {
    String? videoUrl = _sharedPreferences.getString(prefsKeyVideoUrl);
    if (videoUrl != null && videoUrl.isNotEmpty) {
      return videoUrl;
    } else {
      return "";
    }
  }

  //----------------------------------------------------------------------------video
  //set video url
  Future<void> setFInalVideoUrl(String finalVideoUrl) async {
    await _sharedPreferences.setString(prefsKeyFinalVideoUrl, finalVideoUrl);
  }

  //get video url
  Future<String> getFinalVideoUrl() async {
    String? finalVideoUrl = _sharedPreferences.getString(prefsKeyFinalVideoUrl);
    if (finalVideoUrl != null && finalVideoUrl.isNotEmpty) {
      return finalVideoUrl;
    } else {
      return "";
    }
  }
}
