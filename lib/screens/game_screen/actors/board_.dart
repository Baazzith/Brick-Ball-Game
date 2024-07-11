import 'dart:async';
import 'dart:math';

import 'package:brick_balls_game/screens/game_screen/game_screen.dart';
import 'package:flame/components.dart';

import 'ball_more.dart';
import 'brick.dart';

class NewBoard extends RectangleComponent with HasGameRef<MainGame> {
  @override
  FutureOr<void> onLoad() async {
    addRowBrick();
    return super.onLoad();
  }

  reset() {
    final allNewBrickComponents = children.query<NewBrick>();
    for (var brick in allNewBrickComponents) {
      brick.removeFromParent();
    }
    final allBallMoreComponents = children.query<BallMore>();
    for (var ballMore in allBallMoreComponents) {
      ballMore.removeFromParent();
    }
  }

  moveBrick() {
    final allNewBrickComponents = children.query<NewBrick>();
    for (var brick in allNewBrickComponents) {
      brick.position.y += 50;//amount of brick moving in after the ball down the screeen
      if (brick.position.y >= game.size.y * 0.9) {
        game.overlays.add('game-over');
      }
    }
    final allBallMoreComponents = children.query<BallMore>();
    for (var ballMore in allBallMoreComponents) {
      ballMore.position.y += 50;
      if (ballMore.position.y >= game.size.y * 0.9) {
        game.overlays.add('game-over');
        game.pauseEngine();
      }
    }
  }
//bricks random positions 
  addRowBrick() async {
    var brickNumber = Random().nextInt(5) + 1;//how many bricks in one row
    List position1 = [1, 3, 5, 7,];
    List position2 = [2, 4, 6, 8];
    position1.shuffle();
    position2.shuffle();
    var isPosition1 = Random().nextBool();
    var currentPosition = isPosition1 ? position1 : position2;

    for (var i = 0; i < brickNumber; i++) {
      var spacer = 20;
      if (currentPosition[i] == 1) {
        spacer = 0;//increases then the first brick space is increase
      }
      if (currentPosition[i] == 8) {
        spacer = 0;
      }
      //in many ball & brick concept
      var score = Random().nextInt(10) + 1;
      var randomBall = Random().nextInt(3);//random ball time
      if (game.ballNumber >= 10) {
        score = Random().nextInt(100) + 1;
        randomBall = Random().nextInt(15);
      } else if (game.ballNumber >= 5) {
        score = Random().nextInt(50) + 1;
        randomBall = Random().nextInt(12);
      } else if (game.ballNumber >= 3) {
        score = Random().nextInt(30) + 1;
      }

      if (randomBall == 0) {
        BallMore ballMore = BallMore(
            position:
                Vector2(game.size.x * currentPosition[i] / 10 + spacer, 50),//distance of new +1 ball  
            score: 1);
        add(ballMore);
      } else {
        NewBrick newBrick = NewBrick(
            position:
                Vector2(game.size.x * currentPosition[i] / 10 + spacer, 50),//distance of new bricks
            score: score);
        add(newBrick);
      }
    }
  }
}
