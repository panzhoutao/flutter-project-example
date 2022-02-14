import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2022/1/7
class SPUtils {
  factory SPUtils() => _getInstance();

  static SPUtils get instance => _getInstance();

  static SPUtils? _instance;

  static SPUtils _getInstance() {
    _instance ??= SPUtils._internal();
    return _instance!;
  }

  SPUtils._internal() {
    // initSharePre();
  }

  late SharedPreferences prefs;

  String kIsInitApp = "isInitApp";
  String kToken = "token";
  String kLocale = 'locale';

  ///init SharedPreferences
  Future<void> initSharePre() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setToken(String? token) async {
    if (token == null) {
      return await prefs.setString(kToken, '');
    }
    return await prefs.setString(kToken, token);
  }

  ///
  String? getToken() {
    String? token = prefs.getString(kToken);
    if (token == '') {
      token = null;
    }
    return token;
  }

  ///
  Locale? getLocal() {
    String? languageCode = prefs.getString(kLocale);
    if (languageCode == null || languageCode.isEmpty) {
      return null;
    }
    Locale? locale = Locale(languageCode);
    return locale;
  }

  ///
  Future? setLocal(Locale locale) async {
    return await prefs.setString(kLocale, locale.languageCode);
  }
}
