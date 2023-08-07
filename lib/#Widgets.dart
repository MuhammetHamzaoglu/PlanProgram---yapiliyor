
//sayfa geçiçi sağlar
Navigator.push(context, MaterialPageRoute(builder: (context) => .....class?....()));
---------------------------------------------------
Text('test yaz', style: TextStyle(fontSize: 25))
----------------------------------------------------------------
// sayfada sağ alt köşeye + butonu ekler.
// Scaffold () içine konulabiltir
floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
----------------------------------------------------------------
// Liste araçları
Column(
      children: [
        ListTile(
          tileColor: Colors.black12,
          title: Text('Toplam Çalışma Süren'),
          onTap: () {},
          //subtitle: Text('Detay', style: TextStyle(fontSize: 25)),
          leading: Icon(Icons.watch_later_rounded),
          //trailing: Icon(Icons.chevron_right),
          trailing: Text('06:30:10', style: TextStyle(fontSize: 25)),
        ),
        SizedBox(height: 10),
        ListTile(
          tileColor: Colors.black12,
          title: Text('Günlük Çalışma Süren'),
          onTap: () {},
          //subtitle: Text('Detay', style: TextStyle(fontSize: 25)),
          leading: Icon(Icons.watch_later_rounded),
          //trailing: Icon(Icons.chevron_right),
          trailing: Text('01:35:10', style: TextStyle(fontSize: 25)),
        ),
      ],
    ),
--------------------------------------------------------------------------
//profil resmi ve kullanıcı biligileri oluşturmak
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    CircleAvatar(
      //backgroundImage: AssetImage('assets/user_profile_image.jpg'),
      radius: 50,
    ),
    SizedBox(height: 100),
    Text(
      'Muhammet Hamzaoğlu',
      style: TextStyle(fontSize: 24),
    ),
    SizedBox(height: 8),
    Text(
      'mahmzaoglu6@mail.com',
      style: TextStyle(fontSize: 18),
    ),
  ],
),

--------------------------------------------------------------------------
// cart formatında liste oluşturmak
Card(
      color: Colors.green[100],
      child: ListTile(
        title: Text("Pazartesi Dersleri"),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Pazartesi_card()));

          setState(() {});
        },
        subtitle: Text("3 Ders"),
        leading: Icon(Icons.play_lesson, color: Colors.white),
        trailing: Icon(Icons.chevron_right, color: Colors.white, size: 30),
      ),
    ),

----------------------------------------------------------------------
// metin girişi
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
----------------------------------------------------------------------
// sayfaya dinamik araçlar eklemek
ListView.builder
(
  itemCount: programDizi.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(programDizi[index].isim),
      subtitle: Text(programDizi[index].zaman),
    );
  },
),
----------------------------------------------------------------------
//Ders ekle girişi_Temel
class DersEkleSayfasi extends StatefulWidget {
  const DersEkleSayfasi({super.key});

  @override
  State<DersEkleSayfasi> createState() => _DersEkleSayfasiState();
}

class _DersEkleSayfasiState extends State<DersEkleSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Ders Ekle',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Ders Adı',
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Tarih',
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Saat',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  NavBarButton1Body = haftalar();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarPages_Class()));

                  //setState(() {});
                },
                child: const Text('Kapat'),
              ),
              TextButton(
                onPressed: () {
                  NavBarButton1Body = haftalar();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarPages_Class()));
                  //setState(() {});
                },
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
---------------------------------------------------------------------------
class haftalar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: PageView.builder(
            controller: pageController,
            itemCount: buttonNames.length,
            itemBuilder: (context, index) {
              return Transform.scale(
                scale: index == currentPageIndex ? 1.2 : 1.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    buttonNames[index],
                    style: TextStyle(color: Colors.blue, fontSize: 15.0),
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
---------------------------------------------------------------------------