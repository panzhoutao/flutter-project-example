import 'package:bot_toast/bot_toast.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/21

void showToast(String text) {
  Toast.showText(text);
}

class Toast {
  static void showText(String text) {
    BotToast.showText(text: text);
  }

  static void showLoading(){
    BotToast.showLoading();
  }

  static void closeAllLoading(){
    BotToast.closeAllLoading();
  }

}
