import 'package:flutter/material.dart';

class BackgroungImage extends StatelessWidget {
  const BackgroungImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.center,
          colors: <Color>[
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(220, 90, 82, 79)
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/2.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
