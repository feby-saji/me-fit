import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceDb {
  late SharedPreferences sharedPref;
  String authKey = 'isAuthenticated';
  String currentUserKey = 'currentUserKey';
  String usereImageKey = 'usereImageKey';
  String userBodyInitialVal = 'userbodydetailsInitDataVal';

  initPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  bool getAuthentication() {
    if (sharedPref.getBool(authKey) == null ||
        sharedPref.getBool(authKey) == false) return false;

    return true;
  }

  void setAuthentication(authValue) async {
    await sharedPref.setBool(authKey, authValue);
  }

  setUserEmail(currentUserEmail) async {
    await sharedPref.setString(currentUserKey, currentUserEmail);
  }

  getUserEmail() {
    return sharedPref.getString(currentUserKey);
  }

  getUserImage() {
    return sharedPref.getString(usereImageKey);
  }

  setUserImage(imgPath) async {
    await sharedPref.setString(currentUserKey, imgPath);
  }

  // initialize hive db data values
  setInitUserBodyDataValues() async {
    await sharedPref.setBool(userBodyInitialVal, true);
  }

  getInitUserBodyDataValues() async {
    return sharedPref.getBool(userBodyInitialVal) ?? false;
  }
}
