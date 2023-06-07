import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth.dart';

import '../text_style.dart';

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

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: sigNout,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            _userUid(),
            _signOutButton(),
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
                                      'assets/images/recovery.png')),
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                      'assets/images/recovery.png')),
                              const Text(
                                'USA Food',
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
                                      'assets/images/recovery.png')),
                              const Text(
                                'Brasil Food',
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
                                      'assets/images/recovery.png')),
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
            )
          ],
        ),
      ),
    );
  }
}
