import 'package:firebase/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final MaterialColor myCustomColor = MaterialColor(0xFFFFFFFF, <int, Color>{
    50: Color.fromARGB(255, 0, 255, 0),
    100: Color.fromARGB(255, 0, 255, 0),
    200: Color.fromARGB(255, 0, 255, 0),
    300: Color.fromARGB(255, 0, 255, 0),
    400: Color.fromARGB(255, 0, 255, 0),
    500: Color.fromARGB(255, 0, 255, 0),
    600: Color.fromARGB(255, 0, 255, 0),
    700: Color.fromARGB(255, 0, 255, 0),
    800: Color.fromARGB(255, 0, 255, 0),
    900: Color.fromARGB(255, 0, 255, 0),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Foods VNT",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: myCustomColor,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      //     debugShowCheckedModeBanner: false,

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WidgetTree(),
        ),
      );
      // Navigator.pop(context, false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 117, 0, 6),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: unnecessary_const
                children: const [
                  SizedBox(
                    width: 50,
                    height: 200,
                  ),
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                  ),
                  SpinKitThreeBounce(
                    //https://pub.dev/packages/flutter_spinkit
                    color: Colors.white,
                    size: 60.0,
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
