import 'dart:async';
import 'package:brick_balls_game/screens/game_screen/game_screen.dart';
import 'package:flame/components.dart';

class BallTemplate extends SpriteComponent with HasGameRef<MainGame> {
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('ball.png');
    size = Vector2.all(40);
    position = Vector2(game.size.x / 2, game.size.y - 50);
    anchor = Anchor.center;
    return super.onLoad();
  }
}
