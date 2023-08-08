import 'package:flutter/material.dart';
import 'rootPage.dart';

void main() {
  runApp(const MyApp());
}

Widget rootPage = NavBarPages_Class();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plan Progrma',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: rootPage,
    );
  }
}

