import 'package:flutter/material.dart';

import '../text_style.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Text(
          'Login',
          style: kBodyText,
        ),
        onPressed: () => {},
      ),
    );
  }
}
