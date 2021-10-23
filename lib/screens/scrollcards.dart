import 'package:flutter/material.dart';
import 'package:moodclicks/screens/qcard.dart';
import 'package:moodclicks/screens/qcard2.dart';

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        Card3(),
        Card2(),
        // MyPage2Widget(),
        // MyPage3Widget(),
      ],
    );
  }
}
