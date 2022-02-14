import 'package:flutter/material.dart';
import 'utils/log_util.dart';
import 'utils/sp_utils.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/12

///Global key
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class Global {
  static Global? _instance;

  static Global get instance => _getInstance();

  factory Global() => _getInstance();

  ///
  static Global _getInstance() {
    return _instance ??= Global._internal();
  }

  Global._internal();

  ///
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SPUtils.instance.initSharePre();
    Log.i('Global init');
  }

}
