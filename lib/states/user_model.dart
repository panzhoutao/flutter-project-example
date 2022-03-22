import 'package:get/get.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:
class UserModel extends GetxController {
  ///
  dynamic _user;

  dynamic get user => _user;

  set user(dynamic user) {
    _user = user;
    update();
  }
}
