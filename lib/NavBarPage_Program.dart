import 'package:flutter/material.dart';

class NavBarButton2 extends StatefulWidget {
  const NavBarButton2({super.key});

  @override
  State<NavBarButton2> createState() => _NavBarButton2State();
}

class _NavBarButton2State extends State<NavBarButton2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("Plan Program"),
        ),
      ),
      body: Container(
        color: Colors.blue[200],
        child: Center(
          //
          child: Text(
            "Program",
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}