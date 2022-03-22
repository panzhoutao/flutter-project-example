import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../example.dart';
import '../states/user_model.dart';
import 'style/theme_data.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/11
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ///
  Future? futureBuilderFuture;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      postFrameCallback();
    });

    futureBuilderFuture = reloadData();
    super.initState();
  }

  @protected
  Future reloadData() async {}

  ///build 后回调
  void postFrameCallback() {}

  @override
  void didChangeDependencies() {
    context.dependOnInheritedWidgetOfExactType();
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    clearAllFocus();
    Toast.closeAllLoading();
    super.deactivate();
  }

  ///
  void clearAllFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  PreferredSizeWidget defaultAppbar({
    String title = '',
    Widget? titleWidget,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
    bool? centerTitle,
    Color backgroundColor = Colors.white,
    Widget? leading,
  }) {
    return AppBar(
      titleSpacing: titleWidget == null ? null : 0,
      title: titleWidget ?? Text(title),
      actions: actions,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      leading: leading,
    );
  }

  ///
  Widget buildDefaultScaffold({
    PreferredSizeWidget? appBar,
    EdgeInsetsGeometry? padding,
    Widget Function()? body,
    Widget? floatingActionButton,
    Color? backgroundColor,
    List<Widget>? persistentFooterButtons,
  }) {
    padding ??= MyThemeData.instance.primaryPadding;

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        backgroundColor: backgroundColor,
        persistentFooterButtons: persistentFooterButtons,
        body: FutureBuilder(
          future: futureBuilderFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            debugPrint('${T.toString()} ${snapshot.connectionState}');

            Widget view = Container();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                view = const Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  debugPrint('${snapshot.error}');
                  // view = _errorWidget(snapshot.error);
                  view = Container();
                } else {
                  view = Padding(
                    padding: padding!,
                    child: body?.call(),
                  );
                }
                break;
              default:
                break;
            }
            return view;
          },
        ),
      ),
    );
  }

}
