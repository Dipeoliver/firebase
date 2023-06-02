// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase/pages/recovery_pag.dart';
import 'package:firebase/pages/signup_pag.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth.dart';
import '../text_style.dart';
import '../widgets/background-image.dart';
import '../widgets/input-field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loading = ValueNotifier<bool>(false);
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Future<void> signInWinthEmailAndPassword() async {
    try {
      await Auth().signInWinthEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      String msg = "";
      setState(() {
        loading.value = false;
      });
      if (e.code == 'network-request-failed') {
        msg = ("Connection error. Check internet connection !");
      } else if (e.code == 'user-not-found') {
        msg = ("E-mail not found. Register!");
      } else if (e.code == 'wrong-password') {
        msg = ("Incorrect password. Try again!");
      } else if (e.code == 'invalid-email') {
        msg = ("The email address is invalid!");
      } else {
        msg = e.code.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(msg),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 128, 7, 4),
      ));
    }
  }

  Widget _submitButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 128, 7, 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(double.infinity, 60),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: loading,
              builder: (context, _) {
                return loading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      );
              },
            ),
          ],
        ),
        onPressed: () {
          loading.value = true;
          if (_controllerEmail.text == "") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('E-mail field can not be empty'),
                backgroundColor: Color.fromARGB(255, 128, 7, 4),
              ),
            );
            loading.value = false;
          } else if (_controllerPassword.text == "") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password field can not be empty'),
                backgroundColor: Color.fromARGB(255, 128, 7, 4),
              ),
            );
            loading.value = false;
          } else {
            signInWinthEmailAndPassword();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroungImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 140,
                    child: Center(
                      child: Text(
                        'FoodsVnt',
                        style: kHeading,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        TextInput(
                          icon: FontAwesomeIcons.solidEnvelope,
                          hint: 'E-mail',
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          obscure: false,
                          controller: _controllerEmail,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextInput(
                              icon: FontAwesomeIcons.lock,
                              hint: 'Password',
                              inputType: TextInputType.text,
                              obscure: true,
                              controller: _controllerPassword,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecoveryPassword(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password ?',
                                style: kBodyText,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 90),
                          child: Column(
                            children: [
                              _submitButton(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            child: Text(
                              'Create New Account',
                              style: kBodyText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
