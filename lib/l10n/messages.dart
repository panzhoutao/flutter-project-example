import 'package:get/get_navigation/src/root/internacionalization.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2022/3/10
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      'hello': '你好 世界',
    },
    'de_DE': {
      'hello': 'Hallo Welt',
    }
  };
}
