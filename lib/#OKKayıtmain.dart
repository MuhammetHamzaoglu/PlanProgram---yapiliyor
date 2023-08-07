import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<Ders> dersListesi = []; // Yeni eklenen dersleri burada saklayacağız

//değişkenler_S
class Ders {
  String dersAdi;
  String dersTarihi;
  String dersSaati;

  Ders(this.dersAdi, this.dersTarihi, this.dersSaati);
}

final TextEditingController dersAdi = TextEditingController();
final TextEditingController dersTarihi = TextEditingController();
final TextEditingController dersSaati = TextEditingController();
//değişkenler_E


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
      home: DersEkle(),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => DersListesi()));
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ],
    );
  }
}

class DersListesi extends StatefulWidget {
  const DersListesi({super.key});

  @override
  State<DersListesi> createState() => _DersListesiState();
}

class _DersListesiState extends State<DersListesi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
