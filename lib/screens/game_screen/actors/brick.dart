import 'dart:async';

import 'package:brick_balls_game/screens/game_screen/game_screen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class NewBrick extends SpriteComponent with HasGameRef<MainGame> {
  NewBrick({required super.position, this.score = 3})
      : super(anchor: Anchor.center, size: Vector2.all(40));

  int score;
  late TextComponent textComponent;

  @override
  FutureOr<void> onLoad() async {
    sprite = game.brickSprite;
    add(RectangleHitbox());
    textComponent = TextComponent(
        text: score.toString(),
        scale: Vector2.all(1),
        anchor: Anchor.center,
        position: Vector2.all(20));
    add(textComponent);
    return super.onLoad();
  }
//on hit decrease the number 
  decreaseScore() {
    score--;
    game.currentScore += 1;
    if (score <= 0) {
      removeFromParent();
    }
    textComponent.text = score.toString();//displaying the updated score
  }
}
