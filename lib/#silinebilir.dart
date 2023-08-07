class Pazartesi_card extends StatefulWidget {
  const Pazartesi_card({super.key});

  @override
  State<Pazartesi_card> createState() => _Pazartesi_cardState();
}

class _Pazartesi_cardState extends State<Pazartesi_card> {
  List<ProgramDizi> programDizi = [];
  String _programIsmi = '';
  String _programZaman = '';
  String _programGun = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pazartesi Dersleri"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ders Adı',
                ),
                onChanged: (value) {
                  setState(() {
                    // Ders adını güncelle
                    _programIsmi = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tarih',
                ),
                onChanged: (value) {
                  setState(() {
                    // Çalışma saatini güncelle
                    _programGun = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Çalışma Saati',
                ),
                onChanged: (value) {
                  setState(() {
                    // Çalışma saatini güncelle
                    _programZaman = value;
                  });
                },
              ),
              SizedBox(height: 30.0),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    // Yeni bir ders ekleyin
                    programDizi.add(ProgramDizi(
                      isim: _programIsmi,
                      zaman: _programZaman,
                      gun: _programGun,
                    ));
                    // Ders adı ve çalışma saatini sıfırlayın
                    _programIsmi = '';
                    _programZaman = '';
                    _programGun = '';
                  });
                },
              ),
            ],
          ),
          Column( 
            children: [
              ListView.builder(
                itemCount: programDizi.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(programDizi[index].isim),
                    subtitle: Text(programDizi[index].zaman),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

-----------------------------------------------------------------------------

class DersEkleOrnek extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  void _saveDers(BuildContext context) {
    String dersAdi = _controller.text;
    if (dersAdi.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ders Kaydedildi'),
            content: Text('Kaydedilen Ders Adı: $dersAdi'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ders Kayıt Uygulaması',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ders Kayıt Uygulaması'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Ders Adı'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveDers(context),
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
---------------------------------------------------------------------

class Haftalar extends StatefulWidget {
  const Haftalar({Key? key}) : super(key: key);

  @override
  _HaftalarState createState() => _HaftalarState();
}

class _HaftalarState extends State<Haftalar> {
  int currentPageIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: PageView.builder(
            controller: pageController,
            itemCount: buttonNames.length,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
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
      ],
    );
  }
}

----------------------------------------------------------------------

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