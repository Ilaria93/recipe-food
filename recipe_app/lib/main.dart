import 'package:flutter/material.dart';
import 'screens/home_page.dart'; // Importa la homepage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ricette App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Imposta la homepage come schermata di avvio
    );
  }
}
