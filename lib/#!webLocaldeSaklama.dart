//web Localde metin Saklama uygulaması
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localstorage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class TodoItem {
  String title;
  bool done;

  TodoItem({required this.title, required this.done});

  Map<String, dynamic> toJSONEncodable() {
    return {'title': title, 'done': done};
  }
}

class TodoList {
  List<TodoItem> items = [];

  List<Map<String, dynamic>> toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final TodoList list = TodoList();
  bool initialized = false;
  TextEditingController controller = TextEditingController();

  _toggleItem(TodoItem item) {
    setState(() {
      item.done = !item.done;
      _saveToStorage();
    });
  }

  _addItem(String title) {
    setState(() {
      final item = TodoItem(title: title, done: false);
      list.items.add(item);
      _saveToStorage();
    });
  }

  _saveToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todos', list.toJSONEncodable().map((e) => e.toString()).toList());
  }

  _clearStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('todos');

    setState(() {
      list.items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localstorage demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        constraints: BoxConstraints.expand(),
        child: FutureBuilder<void>(
          future: _loadSavedNotes(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            List<Widget> widgets = list.items.map((item) {
              return CheckboxListTile(
                value: item.done,
                title: Text(item.title),
                selected: item.done,
                onChanged: (_) {
                  _toggleItem(item);
                },
              );
            }).toList();

            return Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: widgets,
                    itemExtent: 50.0,
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'What to do?',
                    ),
                    onEditingComplete: _save,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.save),
                        onPressed: _save,
                        tooltip: 'Save',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: _clearStorage,
                        tooltip: 'Clear storage',
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _loadSavedNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotes = prefs.getStringList('todos');
    if (savedNotes != null && savedNotes.isNotEmpty) {
      setState(() {
        list.items = savedNotes.map((item) {
          final Map<String, dynamic> decodedItem = Map.from(Map.fromEntries(item.split(', ').map((e) {
            final List<String> keyValue = e.split(':');
            final String key = keyValue[0].trim();
            String value = keyValue[1].trim();
            if (value == 'true') {
              value = 'true';
            } else if (value == 'false') {
              value = 'false';
            }
            return MapEntry(key, value);
          })));

          return TodoItem(
            title: decodedItem['title']!,
            done: decodedItem['done'] == 'true',
          );
        }).toList();
      });
    }
  }

  void _save() {
    _addItem(controller.value.text);
    controller.clear();
  }
}
