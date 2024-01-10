import 'package:flutter/widgets.dart';
import 'package:malhar_2023/constants/dino_constants.dart';

// import 'constants.dart';
import 'game_object.dart';
import 'sprite.dart';

Sprite groundSprite = Sprite()
  // ..imagePath = "assets/images/dino_background.png"
  ..imagePath = "assets/images/dino_background.png"
  ..imageWidth = 2399
  ..imageHeight = 1150;

class Ground extends GameObject {
  final Offset worldLocation;

  Ground({required this.worldLocation});

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worlToPixelRatio,
      screenSize.height / 0.85 - groundSprite.imageHeight,
      groundSprite.imageWidth.toDouble(),
      groundSprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(groundSprite.imagePath);
  }
}
