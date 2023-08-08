import 'package:flutter/material.dart';
import 'Variable.dart';//

//--------------------------------Değişkenler-------------------------------------------

Widget bodyContent = NavBarButton1();
//Widget NavBarButton1Body = Haftalar();


class NavBarButton1 extends StatefulWidget {
  const NavBarButton1({super.key});

  @override
  State<NavBarButton1> createState() => _NavBarButton1State();
}

class _NavBarButton1State extends State<NavBarButton1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("Plan Program"),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            color: Colors.black38,
            child: SizedBox(
              height: 40,
              child: PageView.builder(
                controller: pageController,
                itemCount: buttonNames.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                    haftaGunleri = currentPageIndex;
                  });
                },
                itemBuilder: (context, index) {
                  return Transform.scale(
                    scale: index == currentPageIndex ? 1.2 : 1.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pageColors[index],
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.all(16.0),
                      ),
                      child: Text(
                        buttonNames[index],
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              //height: 200,
              color: Colors.black12,
              child: ListView.builder(
                itemCount: dersListesi.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.green[200],
                    child: ListTile(
                      title: Text(dersListesi[index].dersAdi),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => .....class?....()));
                        setState(() {});
                      },
                      subtitle: Text(dersListesi[index].dersTarihi + " - " + dersListesi[index].dersSaati),
                      leading: Icon(Icons.play_lesson, color: Colors.white),
                      //trailing: Icon(Icons.chevron_right, color: Colors.white, size: 30),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dersAdi.clear();
          dersTarihi.clear();
          dersSaati.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context) => DersEkle()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DersEkle extends StatefulWidget {
  DersEkle({super.key});

  @override
  State<DersEkle> createState() => _DersEkleState();
}

class _DersEkleState extends State<DersEkle> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Ders Oluştur')),
      actions: [
        Column(
          children: [
            TextField(
              controller: dersAdi,
              decoration: InputDecoration(labelText: 'Ders Adı'),
            ),
            TextField(
              controller: dersTarihi,
              decoration: InputDecoration(labelText: 'Çalışma Tarihi'),
            ),
            TextField(
              controller: dersSaati,
              decoration: InputDecoration(labelText: 'Çalışma Saati'),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
            TextButton(
              onPressed: () {
                Ders yeniDers = Ders(dersAdi.text, dersTarihi.text, dersSaati.text);
                dersListesi.add(yeniDers); // Yeni dersi listeye ekle
                Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarButton1()));
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ],
    );
  }
}
