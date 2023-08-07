import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sembast_web/sembast_web.dart';

void main() async {
  
  runApp(const MyApp());
}




Future<Database> openWebDb() async {
  databaseFactory = databaseFactoryFfi;
  Database db = await openDatabase('/test/test.db');
  return db;
}

class Ders {
  String dersAdi;
  String dersTarihi;
  String dersSaati;

  Ders(this.dersAdi, this.dersTarihi, this.dersSaati);

  // Ders nesnesini Map'e dönüştüren fonksiyon
  Map<String, dynamic> toMap() {
    return {
      'dersAdi': dersAdi,
      'dersTarihi': dersTarihi,
      'dersSaati': dersSaati,
    };
  }
}

class DersDatabase {
  // Veritabanı tablo ve kolon adları
  static final String tableName = 'dersler';
  static final String columnId = 'id';
  static final String columnDersAdi = 'dersAdi';
  static final String columnDersTarihi = 'dersTarihi';
  static final String columnDersSaati = 'dersSaati';

  // Veritabanı bağlantısı oluşturmak için bir yardımcı fonksiyon
  static Future<Database> _openDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'dersler.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE $tableName (
          $columnId INTEGER PRIMARY KEY,
          $columnDersAdi TEXT NOT NULL,
          $columnDersTarihi TEXT NOT NULL,
          $columnDersSaati TEXT NOT NULL
        )
      ''');
    });
  }

  // Yeni dersi veritabanına eklemek için fonksiyon
  static Future<void> insertDers(Ders ders) async {
    final db = await _openDatabase();
    await db.insert(tableName, ders.toMap());
  }

  // Tüm dersleri veritabanından getiren fonksiyon
  static Future<List<Ders>> getDersler() async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      return Ders(
        maps[index][columnDersAdi],
        maps[index][columnDersTarihi],
        maps[index][columnDersSaati],
      );
    });
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
                await DersDatabase.insertDers(yeniDers); // Yeni dersi veritabanına ekle
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

  // Dersleri veritabanından yüklemek için fonksiyon
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
                //Navigator.push(context, MaterialPageRoute(builder: (context) => .....class?....()));
                setState(() {});
              },
              subtitle: Text(_dersListesi[index].dersTarihi + " - " + _dersListesi[index].dersSaati),
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
