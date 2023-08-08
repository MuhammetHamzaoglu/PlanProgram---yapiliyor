import 'package:flutter/material.dart';//


enum ButtonNavBar { Dersler, Program } // Nav bar Sayfa geçişleri için anlamlı numaralandırma yapıldı

int currentPageIndex = 0;
int haftaGunleri = 0;
PageController pageController = PageController(initialPage: 0, viewportFraction: 0.4);

List<String> buttonNames = [
  'Pazartesi',
  'Salı',
  'Çarşamba',
  'Perşembe',
  'Cuma',
  'Cumartesi',
  'Pazar',
];

List<Color> pageColors = [
  Colors.red.shade200,
  Colors.yellow.shade200,
  Colors.blue.shade200,
  Colors.green.shade200,
  Colors.orange.shade200,
  Colors.purple.shade200,
  Colors.cyan.shade200,
];

List<Ders> dersListesi = []; // Yeni eklenen dersleri burada saklayacağız


class Ders {
  String dersAdi;
  String dersTarihi;
  String dersSaati;

  Ders(this.dersAdi, this.dersTarihi, this.dersSaati);
}

final TextEditingController dersAdi = TextEditingController();
final TextEditingController dersTarihi = TextEditingController();
final TextEditingController dersSaati = TextEditingController();

