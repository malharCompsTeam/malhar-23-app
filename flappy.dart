import 'package:flutter/material.dart';

import 'screen/flappy_bird_game.dart';

class FlappyWindow extends StatelessWidget {
  const FlappyWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlappyBirdGame(),
    );
  }
}
