import 'dart:async';

import 'package:brick_balls_game/screens/providers/main_app_provider.dart';
import 'package:brick_balls_game/screens/game_screen/game_screen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import 'ball_more.dart';
import 'brick.dart';

class NewBall extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MainGame> {
  Vector2 direction = Vector2(0, 0);
  Vector2 localTargetPosition = Vector2.zero();
  bool isSetLocalPosition = true;
  double gravity = 1;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('ball.png');
    size = Vector2.all(40);
    position = Vector2(game.size.x / 2, game.size.y - 50);
    anchor = Anchor.center;
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.isBuong && isSetLocalPosition) {
      localTargetPosition = game.targetPosition;
      isSetLocalPosition = false;
    }
    moving(dt);
    super.update(dt);
  }

  void moving(double dt) async {
    if (game.isBuong) {
      direction = direction.scaled(0.9) +
          (localTargetPosition - position).normalized().scaled(0.1);
      localTargetPosition = position + direction * 100.0;
      position += direction * dt * 400.0;
      position.y += gravity;
    }

    if (position.y > game.size.y ||
        position.y < 0 ||
        position.x < 0 ||
        position.x > game.size.x) {
      removeFromParent();
    }
  }

  void vibrate() async {
    var check = await Vibration.hasVibrator();
    if (check != null) {
      if (check) {
        Vibration.vibrate(duration: 500);
      }
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    //on collision sound
    super.onCollisionStart(intersectionPoints, other);
    if (other is NewBrick) {
      reflectFromBrick(intersectionPoints, other);
      if (game.buildContext!.read<MainAppProvider>().isSoundTurnOn) {
        FlameAudio.play('hit.mp3');
      }
      if (game.buildContext!.read<MainAppProvider>().isVibratonTurnOn) {
        vibrate();
      }
      //decrese number inside brick
      other.decreaseScore();
    } else if (other is ScreenHitbox<FlameGame<World>>) {
      reflectFromBoard(intersectionPoints);
    } else if (other is BallMore) { // here the ball more hit and reducing
      other.removeFromParent();
      game.ballNumber += 1;
    }
  }

  void reflectFromBoard(Set<Vector2> intersectionPoints) {
    final isTopHit = intersectionPoints.first.y <= gameRef.board!.position.y;
    final isLeftHit = intersectionPoints.first.x <= gameRef.board!.position.x ||
        intersectionPoints.first.y <=
            gameRef.board!.position.y + gameRef.board!.size.y;
    final isRightHit = intersectionPoints.first.x >=
            gameRef.board!.position.x + gameRef.board!.size.x ||
        intersectionPoints.first.y <=
            gameRef.board!.position.y + gameRef.board!.size.y;

    if (isTopHit) {
      direction.y *= -1;
    } else if (isLeftHit || isRightHit) {
      direction.x *= -1;
    }
  }

  void reflectFromBrick(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    var second = intersectionPoints.toList()[1];
    Vector2 center = Vector2((intersectionPoints.first.x + second.x) / 2,
        (intersectionPoints.first.y + second.y) / 2);

    if ((other.position.x - center.x).abs() < 20.0 &&
        center.y > other.position.y) {
      direction.y *= -1;
       print("bottom");

      return;
    } else if (center.x > other.position.x && center.y > other.position.y) {
       print("bottom right");
      direction.x *= -1;
      return;
    } else if (center.x < other.position.x && center.y > other.position.y) {
       print("bottom left");
      direction.x *= -1;
      return;
    }

    if ((other.position.x - center.x).abs() < 20.0 &&
        center.y < other.position.y) {
      direction.y *= -1;
    } else if (center.x > other.position.x && center.y < other.position.y) {
       print("top right");
      direction.x *= -1;
      return;
    } else if (center.x < other.position.x && center.y < other.position.y) {
       print("top left");
      direction.x *= -1;
      return;
    }
  }
}
