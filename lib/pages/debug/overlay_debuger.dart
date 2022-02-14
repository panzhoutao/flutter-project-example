import 'dart:async';
import 'package:flutter/material.dart';
import 'test_page.dart';

///
OverlayEntry? debugOverlayEntry;

///
showDebugBtn(BuildContext context, {Widget? button, bool isDelay = true}) {
  if (debugOverlayEntry != null) {
    return;
  }

  OverlayState? overlay = Overlay.of(context);

  //
  void fun() {
    debugOverlayEntry = OverlayEntry(
      builder: (BuildContext context) => const DraggableButtonWidget(),
    );

    overlay!.insert(debugOverlayEntry!);
  }

  if (!isDelay) {
    fun();
  } else {
    Timer(const Duration(milliseconds: 500), () {
      fun();
    });
  }
}

///
dismissDebugBtn() {
  debugOverlayEntry?.remove();
  debugOverlayEntry = null;
}

///
bool debugBtnIsShow() {
  return !(debugOverlayEntry == null);
}

class DraggableButtonWidget extends StatefulWidget {
  const DraggableButtonWidget({
    Key? key,
    this.title = 'test',
    this.btnSize = 66,
  }) : super(key: key);

  final String title;
  final double btnSize;

  @override
  _DraggableButtonWidgetState createState() => _DraggableButtonWidgetState();
}

class _DraggableButtonWidgetState extends State<DraggableButtonWidget> {
  double left = 30;
  double top = 100;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    ///默认点击事件
    Widget w;
    Color primaryColor = Colors.red;
    primaryColor = primaryColor.withOpacity(0.6);
    w = GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TestPage(),
          ),
        );
      },
      onPanUpdate: _dragUpdate,
      child: Container(
        width: widget.btnSize,
        height: widget.btnSize,
        color: primaryColor,
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );

    ///圆形
    w = ClipRRect(
      borderRadius: BorderRadius.circular(widget.btnSize / 2),
      child: w,
    );

    ///计算偏移量限制
    if (left < 1) {
      left = 1;
    }
    if (left > screenWidth - widget.btnSize) {
      left = screenWidth - widget.btnSize;
    }

    if (top < 1) {
      top = 1;
    }
    if (top > screenHeight - widget.btnSize) {
      top = screenHeight - widget.btnSize;
    }
    w = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top),
      child: w,
    );
    return w;
  }

  _dragUpdate(DragUpdateDetails detail) {
    Offset offset = detail.delta;
    left = left + offset.dx;
    top = top + offset.dy;
    setState(() {});
  }
}
