import 'package:avanger_page_reveal/page_reveal.dart';
import 'package:avanger_page_reveal/pager_indicator.dart';
import 'package:avanger_page_reveal/pages.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avengers Page Reveal',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Page(
          viewModel: pages[0],
          percentVisible: 1.0,
        ),
        PageReveal(
          revealPercent: 1.0,
          child: Page(
            viewModel: pages[1],
            percentVisible: 1.0,
          ),
        ),
        PageIndicator(
          viewModel:
          PageIndicatorViewModel(
              pages,
              1,
              SlideDirection.leftToRight,
              1.0
          ),
        )
      ],
    ));
  }
}
