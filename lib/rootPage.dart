import 'package:flutter/material.dart';

import 'NavBarPage_Dersler.dart';
import 'NavBarPage_Program.dart';
import 'Variable.dart';


class NavBarPages_Class extends StatefulWidget {
  const NavBarPages_Class({super.key});

  @override
  State<NavBarPages_Class> createState() => _NavBarPages_ClassState();
}

class _NavBarPages_ClassState extends State<NavBarPages_Class> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyContent, // Varsayılan Sayfa: AnaSayfa()
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[200],
        type: BottomNavigationBarType.fixed,
        //unselectedItemColor: ColFdors.red.withOpacity(1),
        //selectedItemColor: Colors.yellow,
        selectedFontSize: 14, //ıcon ile text arası medafe
        unselectedFontSize: 14, // tüm textin boyutu
        iconSize: 30,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book_sharp), label: "Dersler"),
          BottomNavigationBarItem(icon: Icon(Icons.rule_rounded), label: "Progam"),
        ], //
        onTap: ((value) {
          setState(() {
            if (value == ButtonNavBar.Dersler.index) {
              bodyContent = NavBarButton1();
            } else if (value == ButtonNavBar.Program.index) {
              bodyContent = NavBarButton2();
            }
          }); //setState, sayfayı yeniler, Build'i yeniden başatır
        }),
      ),
    );
  }
} 