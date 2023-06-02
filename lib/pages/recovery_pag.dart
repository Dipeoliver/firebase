// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase/auth.dart';
import 'package:firebase/widgets/input-field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../text_style.dart';
import '../widgets/background-image.dart';

class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({super.key});

  @override
  State<RecoveryPassword> createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  final loading = ValueNotifier<bool>(false);
  final TextEditingController _controllerEmail = TextEditingController();

  Future<void> sendPasswordResetEmail() async {
    try {
      await Auth().sendPasswordResetEmail(
        email: _controllerEmail.text,
      );
      _controllerEmail.text = "";
      loading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text('Email successfully sent.'),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 128, 7, 4),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String msg = "";
      setState(() {
        loading.value = false;
      });
      if (e.code == 'network-request-failed') {
        msg = ("Connection error. Check internet connection !");
      } else if (e.code == 'user-not-found') {
        msg = ("E-mail not found. Register !");
      } else if (e.code == 'invalid-email') {
        msg = ("The email address is invalid !");
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
                        'Send',
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
          } else {
            sendPasswordResetEmail();
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context, false),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/images/recovery.png"),
                  ),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Forgot your password?',
                        style: kSubHeading,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          'Please enter the E-mail associated with your account and we will send you a link with instructions for resetting your password.',
                          style: kBodyText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 40),
                    child: Column(
                      children: [
                        _submitButton(),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: Text(
                            'Cancel',
                            style: kBodyText,
                          ),
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
