import 'package:flutter/material.dart';

import '../global.dart';
import '../pages/router_manage.dart';
import 'sp_utils.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2022/1/5
class LoginUtils {
  /// 登录
  static void login(BuildContext context) async {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Container(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }

  ///退出登录
  static void loginOut() async {
    SPUtils.instance.setToken(null).then(
      (value) {
        BuildContext context = rootNavigatorKey.currentState!.overlay!.context;

        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutersManager.welcome,
          (route) => false,
        );
      },
    );
  }
}
