import 'package:get/get.dart';
import 'welcome/welcome.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/11
class RoutersManager {
  static String welcome = '/';

  ///
  static List<GetPage> routers = [
    GetPage(
      name: welcome,
      page: () => const MyHomePage(title: ''),
    ),
  ];
}
