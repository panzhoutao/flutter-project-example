import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../utils/sp_utils.dart';

/// now language
class LocaleModel with ChangeNotifier {
  Locale _locale = S.delegate.supportedLocales[0];

  Locale get locale => _locale;

  void setLocale(locale) async {
    _locale = locale;
    S.load(locale);
    await SPUtils.instance.setLocal(locale);
    notifyListeners();
  }
}
