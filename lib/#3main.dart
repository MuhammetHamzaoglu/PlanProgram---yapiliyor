import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:indexed_db' as idb;

void main() async {
  runApp(const MyApp());
}

class Ders {
  String dersAdi;
  String dersTarihi;
  String dersSaati;

  Ders(this.dersAdi, this.dersTarihi, this.dersSaati);

  Map<String, dynamic> toMap() {
    return {
      'dersAdi': dersAdi,
      'dersTarihi': dersTarihi,
      'dersSaati': dersSaati,
    };
  }
}

class DersDatabase {
  static Future<void> insertDers(Ders ders) async {
    final database = await html.window.indexedDB.open('dersler.db');
    final transaction = database.transaction('dersler', 'readwrite');
    final store = transaction.objectStore('dersler');
    store.add(ders.toMap());
    await transaction.completed;
    await database.close();
  }

  static Future<List<Ders>> getDersler() async {
    final database = await html.window.indexedDB.open('dersler.db');
    final transaction = database.transaction('dersler', 'readonly');
    final store = transaction.objectStore('dersler');
    final request = store.getAll();
    await transaction.completed;
    await database.close();

    final results = request.result as List<dynamic>;
    final dersler = results.map((result) => Ders(
          result['dersAdi'] as String,
          result['dersTarihi'] as String,
          result['dersSaati'] as String,
        )).toList();
    return dersler;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

final TextEditingController dersAdi = TextEditingController();
final TextEditingController dersTarihi = TextEditingController();
final TextEditingController dersSaati = TextEditingController();

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
              onPressed: () async {
                Ders yeniDers = Ders(dersAdi.text, dersTarihi.text, dersSaati.text);
                await DersDatabase.insertDers(yeniDers);
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
  List<Ders> _dersListesi = [];

  @override
  void initState() {
    super.initState();
    _loadDersler();
  }

  Future<void> _loadDersler() async {
    List<Ders> dersler = await DersDatabase.getDersler();
    setState(() {
      _dersListesi = dersler;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _dersListesi.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green[200],
            child: ListTile(
              title: Text(_dersListesi[index].dersAdi),
              onTap: () {
                setState(() {});
              },
              subtitle: Text(_dersListesi[index].dersTarihi + " - " + _dersListesi[index].dersSaati),
              leading: Icon(Icons.play_lesson, color: Colors.white),
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
