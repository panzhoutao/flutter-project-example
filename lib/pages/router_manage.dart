import 'package:flutter/material.dart';

import 'welcome/welcome.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/11
class RoutersManager {
  static String welcome = '/';

  ///
  static Map<String, WidgetBuilder> routers = {
    welcome: (context, {arguments}) => const MyHomePage(title: '',),
    // login: (context, {arguments}) => LoginPage(registerLocal: arguments),
  };

  ///
  static Route<dynamic>? generator(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;
    Function? widgetBuilder = routers[name];
    if (widgetBuilder != null) {
      return MaterialPageRoute(
        settings: RouteSettings(name: name),
        builder: (context) {
          return args == null
              ? widgetBuilder(context)
              : widgetBuilder(context, arguments: args);
        },
      );
    } else {
      return null;
    }
  }
}

///
class MyNavigator {
  static Future navigateTo(
    BuildContext context,
    String path, {
    Object? params,
  }) {
    return Navigator.pushNamed(
      context,
      path,
      arguments: params,
    );
  }
}
