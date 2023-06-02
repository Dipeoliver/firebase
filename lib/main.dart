import 'package:firebase/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final MaterialColor myCustomColor = MaterialColor(0xFF750006, <int, Color>{
    50: Color.fromARGB(255, 117, 0, 6),
    100: Color.fromARGB(255, 117, 0, 6),
    200: Color.fromARGB(255, 117, 0, 6),
    300: Color.fromARGB(255, 117, 0, 6),
    400: Color.fromARGB(255, 117, 0, 6),
    500: Color.fromARGB(255, 117, 0, 6),
    600: Color.fromARGB(255, 117, 0, 6),
    700: Color.fromARGB(255, 117, 0, 6),
    800: Color.fromARGB(255, 117, 0, 6),
    900: Color.fromARGB(255, 117, 0, 6),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Foods VNT",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: myCustomColor,
      ),
      home: WidgetTree(),
    );
  }
}
