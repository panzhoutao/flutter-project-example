import 'package:flutter/foundation.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:
class UserModel extends ChangeNotifier {
  ///
  dynamic _user;

  dynamic get user => _user;

  set user(dynamic user) {
    _user = user;
    notifyListeners();
  }
}
