import 'package:firebase/auth.dart';
import 'package:firebase/pages/home_page.dart';
import 'package:firebase/pages/login-page.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshop) {
        if (snapshop.hasData) {
          return HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
