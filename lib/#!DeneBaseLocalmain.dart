import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'notes_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY, content TEXT)',
      );
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}
class Note {
  final int id;
  final String content;

  Note({
    required this.id,
    required this.content,
  });

  // Bu kısımda toMap metodu eklendi.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }
}

class MyApp extends StatelessWidget {
  final Database database;

  MyApp({required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      home: NoteListPage(database: database),
    );
  }
}

class NoteListPage extends StatefulWidget {
  final Database database;

  NoteListPage({required this.database});

  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final List<Map<String, dynamic>> noteMaps = await widget.database.query('notes');
    setState(() {
      notes = noteMaps.map((map) => Note(
        id: map['id'],
        content: map['content'],
      )).toList();
    });
  }

  Future<void> _saveNote(String content) async {
    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      content: content,
    );
    await widget.database.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.content),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? content = await showDialog<String>(
            context: context,
            builder: (context) => _NoteInputDialog(),
          );
          if (content != null) {
            _saveNote(content);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _NoteInputDialog extends StatefulWidget {
  @override
  _NoteInputDialogState createState() => _NoteInputDialogState();
}

class _NoteInputDialogState extends State<_NoteInputDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Note'),
      content: TextField(
        controller: _controller,
        maxLines: 3,
        decoration: InputDecoration(labelText: 'Note Content'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}