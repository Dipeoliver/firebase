import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth.dart';

import '../text_style.dart';
import 'list_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> sigNout() async {
    await Auth().sigNout();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text(user?.email ?? "User mail");
  }

  @override
  Widget build(BuildContext context) {
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
              'Welcome: ${user?.email ?? "User mail".toString()}',
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
