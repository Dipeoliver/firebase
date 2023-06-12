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
    return const Text('Foods VNT', style: TextStyle(color: Colors.white));
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
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 128, 7, 4),
        actions: [
          IconButton(
            color: Colors.white,
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
        padding: const EdgeInsets.all(5),
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
                            builder: (context) => ListPage('Italian'),
                          ),
                        );
                      },
                      child: Container(
                        child: Card(
                          color: const Color.fromARGB(255, 128, 7, 4),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/home_page_italian.jpg',
                                fit: BoxFit.cover,
                              )),
                              const Text(
                                'Italian Food',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListPage('Mexican'),
                          ),
                        );
                      },
                      child: Container(
                        child: Card(
                          color: const Color.fromARGB(255, 128, 7, 4),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/home_page_mexican.jpg',
                                fit: BoxFit.cover,
                              )),
                              const Text(
                                'Mexican Food',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListPage('German'),
                          ),
                        );
                      },
                      child: Container(
                        child: Card(
                          color: const Color.fromARGB(255, 128, 7, 4),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/home_page_german.jpg',
                                fit: BoxFit.cover,
                              )),
                              const Text(
                                'German Food',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListPage('Japanese'),
                          ),
                        );
                      },
                      child: Container(
                        child: Card(
                          color: const Color.fromARGB(255, 128, 7, 4),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/home_page_japanese.jpg',
                                fit: BoxFit.cover,
                              )),
                              const Text(
                                'Japan Food',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
