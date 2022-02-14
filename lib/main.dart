import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'example.dart';
import 'global.dart';
import 'pages/debug/overlay_debuger.dart';
import 'states/locale_model.dart';
import 'states/user_model.dart';
import 'widget/style/theme_data.dart';

void main() {
  Global.instance.init().then(
    (e) {
      return runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => myApp, // Wrap your app
        ),
      );
    },
  );
}

///
Widget myApp = MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => UserModel()),
    ChangeNotifierProvider(create: (context) => LocaleModel()),
  ],
  child: MyApp(),
);

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final botToastBuilder = BotToastInit();

  ///
  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates => [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () {
        return Consumer<LocaleModel>(
          builder: (BuildContext context, currentLocale, Widget? child) {
            return MaterialApp(
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
                return S().app_name;
              },
              initialRoute: RoutersManager.welcome,
              onGenerateRoute: RoutersManager.generator,
              theme: MyThemeData.instance.themeData(),
              localizationsDelegates: _localizationsDelegates,
              supportedLocales: S.delegate.supportedLocales,
              locale: currentLocale.locale,
              localeResolutionCallback: (
                Locale? locale,
                Iterable<Locale> supportedLocales,
              ) {
                return locale;
              },
            );
          },
        );
      },
    );
  }
}
