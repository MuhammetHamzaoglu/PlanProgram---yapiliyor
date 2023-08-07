import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plan Program',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;

  void startTimer() {
    const duration = Duration(seconds: 5);
    _timer = Timer.periodic(duration, (Timer timer) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Uyarı"),
            content: Text("Timer çalışıyor!"),
            actions: [
              TextButton(
                // TextButton kullanımı
                child: Text("Kapat"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer ve Uyarı Penceresi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // ElevatedButton kullanımı
              onPressed: startTimer,
              child: Text("Timer'ı Başlat"),
            ),
            ElevatedButton(
              // ElevatedButton kullanımı
              onPressed: stopTimer,
              child: Text("Timer'ı Durdur"),
            ),
          ],
        ),
      ),
    );
  }
}
