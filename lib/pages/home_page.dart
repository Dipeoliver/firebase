import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../text_style.dart';
import 'list_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";

  final User? user = Auth().currentUser;

  Future<void> sigNout() async {
    await Auth().sigNout();
  }

  Widget _title() {
    return const Text('Foods VNT');
  }

  Future<void> readUser() async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("UserId").doc(user?.email);

      await documentReference.get().then((datasnapshot) {
        setState(() {
          userName = datasnapshot['name'];
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(e.toString()),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 128, 7, 4),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    readUser();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              sigNout();
            },
          ),
        ],
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome: ' + userName,
              style: kBodyTextBlack,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListPage(),
                          ),
                        );
                      },
                      child: Container(
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/italy.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const Text(
                                'Italian Food',
                                style: kBodyTextBlack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/mexico.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const Text(
                                'Mexican Food',
                                style: kBodyTextBlack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/germany.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const Text(
                                'Germany Food',
                                style: kBodyTextBlack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/japan.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const Text(
                                'Japan Food',
                                style: kBodyTextBlack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
