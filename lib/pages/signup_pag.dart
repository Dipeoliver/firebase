// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../auth.dart';
import '../text_style.dart';
import '../widgets/background-image.dart';
import '../widgets/input-field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final loading = ValueNotifier<bool>(false);
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      Navigator.pop(context, false);
    } on FirebaseAuthException catch (e) {
      String msg = "";
      setState(() {
        loading.value = false;
      });
      if (e.code == 'network-request-failed') {
        msg = ("Connection error. Check internet connection !");
      } else if (e.code == 'weak-password') {
        msg = ("The password is too Weak!");
      } else if (e.code == 'email-already-in-use') {
        msg = ("The email address is already being used by another account!");
      } else if (e.code == 'invalid-email') {
        msg = ("The email address is invalid!.");
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

  saveUser() {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("UserId")
          .doc(_controllerEmail.text);

      Map<String, dynamic> User = {
        "name": _controllerName.text,
        "email": _controllerEmail.text
      };

      documentReference.set(User).whenComplete(() => {});
    } catch (e) {
      print(e.toString() + "!!!!!!!ERRO AO Salvar");
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
                        'Save',
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
          if (_controllerName.text == "") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Name field can not be empty'),
                backgroundColor: Color.fromARGB(255, 128, 7, 4),
              ),
            );
            loading.value = false;
          } else if (_controllerEmail.text == "") {
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
            createUserWithEmailAndPassword();
            saveUser();
          }
        },
      ),
    );
  }

  @override
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
                    width: 150,
                    height: 150,
                    child: Image.asset("assets/images/user.png"),
                  ),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Register your account!',
                        style: kSubHeading,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        TextInput(
                          icon: FontAwesomeIcons.addressCard,
                          hint: 'Name',
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          obscure: false,
                          controller: _controllerName,
                        ),
                      ],
                    ),
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
                        TextInput(
                          icon: FontAwesomeIcons.lock,
                          hint: 'Password',
                          inputType: TextInputType.text,
                          obscure: true,
                          controller: _controllerPassword,
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
