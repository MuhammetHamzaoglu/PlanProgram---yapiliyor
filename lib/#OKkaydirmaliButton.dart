import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scrollable Buttons'),
        ),
        body: Center(
          child: ScrollableButtons(),
        ),
      ),
    );
  }
}

class ScrollableButtons extends StatefulWidget {
  @override
  _ScrollableButtonsState createState() => _ScrollableButtonsState();
}

class _ScrollableButtonsState extends State<ScrollableButtons> {
  final List<String> buttonNames = [
    "Button 1",
    "Button 2",
    "Button 3",
    "Button 4",
    "Button 5",
    "Button 6",
    "Button 7",
  ];

  PageController _pageController = PageController(initialPage: 0, viewportFraction: 0.4);

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        controller: _pageController,
        itemCount: buttonNames.length,
        itemBuilder: (context, index) {
          return Transform.scale(
            scale: index == _currentPageIndex ? 1.2 : 1.0,
            child: ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.all(16.0),
              ),
              child: Text(
                buttonNames[index],
                style: TextStyle(color: Colors.blue, fontSize: 16.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
