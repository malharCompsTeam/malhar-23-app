import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malhar_2023/screen/dino_run_game.dart';
// import 'cactus.dart';
// import 'cloud.dart';
// import 'dino.dart';
// import 'game_object.dart';
// import 'ground.dart';
// import 'constants.dart';




//change my to DinoRunWindow
class DinoRunWindow extends StatelessWidget {
  const DinoRunWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return const MaterialApp(
      title: 'Flutter Dino',
      debugShowCheckedModeBanner: false,
      home: DinoRunGame(),
    );
  }
}
