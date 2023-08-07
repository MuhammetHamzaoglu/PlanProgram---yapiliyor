import 'package:flutter/material.dart';

/// Flutter code sample for [showDialog].

void main() => runApp(const ShowDialogExampleApp());

class ShowDialogExampleApp extends StatelessWidget {
  const ShowDialogExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DialogExample(),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('showDialog Sample')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => _dialogBuilder(context),
          child: const Text('Open Dialog'),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: const Text('Ders Ekle'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ders Adı',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tarih',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Saat',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Çık'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Kaydet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
