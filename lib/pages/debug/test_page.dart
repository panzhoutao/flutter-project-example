import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<Widget> get children {
    List<Widget> views = [];

    // views.add(
    //   ElevatedButton(
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => HttpLogListWidget(),
    //         ),
    //       );
    //     },
    //     child: const Text('http log'),
    //   ),
    // );

    return views;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('debug'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: children,
          ),
        ],
      ),
    );
  }
}
