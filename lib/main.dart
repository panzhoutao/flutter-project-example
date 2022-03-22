import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'example.dart';
import 'global.dart';
import 'l10n/messages.dart';
import 'widget/style/theme_data.dart';
import 'dart:ui' as ui;

void main() {
  Global.instance.init().then(
    (e) {
      return runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => MyApp(), // Wrap your app
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final botToastBuilder = BotToastInit();

  ///
  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () {
        return GetMaterialApp(
          navigatorKey: rootNavigatorKey,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            ScreenUtil.setContext(context);
            child = botToastBuilder(context, child);
            child = DevicePreview.appBuilder(context, child);
            return child;
          },
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'example',
          onGenerateTitle: (context) {
            return 'example';
          },
          getPages: RoutersManager.routers,
          initialRoute: RoutersManager.welcome,
          theme: MyThemeData.instance.themeData(),
          localizationsDelegates: _localizationsDelegates,
          translations: Messages(),
          locale: ui.window.locale,
          fallbackLocale: const Locale('en', 'US'),
        );
      },
    );
  }
}
