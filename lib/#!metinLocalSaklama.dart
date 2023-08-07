import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Not Defteri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotePage(),
    );
  }
}

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _notes = [];

  // LocalStorage nesnesini oluşturun
  LocalStorage storage = LocalStorage('notes');

  @override
  void initState() {
    super.initState();
    _loadSavedNotes();
  }

  void _loadSavedNotes() async {
    await storage.ready; // LocalStorage hazır olana kadar bekleyin
    List<String>? savedNotes = storage.getItem('notes');
    if (savedNotes != null) {
      setState(() {
        _notes = List<String>.from(savedNotes);
      });
    }
  }

  void _saveNote() async {
    String newNote = _textEditingController.text;
    if (newNote.isNotEmpty) {
      setState(() {
        _notes.add(newNote);
      });

      await storage.ready; // LocalStorage hazır olana kadar bekleyin
      storage.setItem('notes', _notes);
    }
  }

  void _clearNotes() async {
    setState(() {
      _notes.clear();
    });

    await storage.ready; // LocalStorage hazır olana kadar bekleyin
    storage.deleteItem('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Defteri'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notes[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(labelText: 'Metin girin'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _saveNote,
                child: Text('Kaydet'),
              ),
              ElevatedButton(
                onPressed: _clearNotes,
                child: Text('Notları Temizle'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
