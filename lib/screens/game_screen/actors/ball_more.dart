import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class BallMore extends SpriteComponent {
  BallMore({required super.position, this.score = 1})
      : super(anchor: Anchor.center, size: Vector2.all(40));
  late TextComponent textComponent;
  int score;

  @override
  FutureOr<void> onLoad() async {
    //ball more(+1 balls)
    sprite = await Sprite.load('ballmore.png');
    add(RectangleHitbox());
    textComponent = TextComponent(
        text: "+${score.toString()}",
        scale: Vector2.all(1),
        anchor: Anchor.center,
        position: Vector2.all(20));
    add(textComponent);
    return super.onLoad();
  }
}
