import 'dart:async';
import 'dart:math';
import 'package:brick_balls_game/configs/styles.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../menu/home_screen.dart';
import '../menu/primary_background.dart';
import 'actors/ball.dart';
import 'actors/board_.dart';
import 'objects/ball_number_component.dart';
import 'objects/ball_template.dart';
import 'objects/home_button.dart';
import 'objects/score_component.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return gameWidget();
  }
}

Widget gameWidget() {
  Flame.device.setPortrait();
  return Scaffold(
    body: SafeArea(
      child: PrimaryBackground(
        child: Container(
          color: const Color.fromARGB(200, 123, 235, 255),//in game widget color 
          margin: const EdgeInsets.only(left: 5, right: 5, bottom: 50),
          child: GameWidget.controlled(
            gameFactory: MainGame.new,
            overlayBuilderMap: {
              "game-over": (context, MainGame gameRef) {
                return Scaffold(
                  body: SafeArea(
                      child: PrimaryBackground(
                    child: Container(
                        color: const Color.fromARGB(255, 244, 244, 244),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, -70),
                                child: Column(
                                  children: [
                                    Text(
                                      "GAME",
                                      style: style.copyWith(fontSize: 64),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(0, -20),
                                      child: Text(
                                        "OVER",
                                        style: style.copyWith(fontSize: 64),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomeScreen()),
                                                  (route) => false);
                                            },
                                            child: Image.asset(
                                                'assets/images/home.png')),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () async {
                                            gameRef.overlays
                                                .remove('game-over');
                                            gameRef.resumeEngine();
                                            await gameRef.initGame();
                                            await gameRef.initGame();
                                          },
                                          child: Image.asset(
                                              'assets/images/play_again.png'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ])),
                  )),
                );
              }
            },
          ),
        ),
      ),
    ),
  );
}

class MainGame extends FlameGame
    with DragCallbacks, HasCollisionDetection, TapCallbacks {
  Paint paint = Paint()
    ..color = const Color.fromRGBO(85, 85, 85, 1)
    ..strokeWidth = 2.0;

  Offset startPoint = Offset.zero;
  Offset endPoint = Offset.zero;
  Vector2 targetPosition = Vector2.zero();
  Vector2 tempPosition = Vector2.zero();
  bool isBuong = false;
  int ballNumber = 1;
  Sprite? brickSprite;
  GameState gameState = GameState.start;
  NewBoard? board;
  ScoreComponent? scoreComponent;
  BallNumberComponent? ballNumberComponent;
  int currentScore = 0;

  @override
  Color backgroundColor() => Colors.transparent;

  Future<void> removeComponents() async {
    if (scoreComponent != null) {
      remove(scoreComponent!);
    }
    if (ballNumberComponent != null) {
      remove(ballNumberComponent!);
    }
    if (board != null) {
      remove(board!);
    }
  }

  initGame() async {
    removeComponents();
    startPoint = Offset(size.x / 2, size.y - size.y * 0.06);//aim line position
    endPoint = startPoint;
    currentScore = 0;
    ballNumber = 1;
    brickSprite = await Sprite.load("brick.png");
    scoreComponent = ScoreComponent(newSize: size);
    ballNumberComponent = BallNumberComponent(newSize: size);
    board = NewBoard();

    addAll([
      scoreComponent!,
      ballNumberComponent!,
      board!,
      HomeButton(),
      BallTemplate(),
      ScreenHitbox(),
    ]);
  }

  updateScore() {
    if (scoreComponent != null) {
      scoreComponent!.text = "SCORE: \n$currentScore";
    }
  }

  updateBallNumber() {
    if (ballNumberComponent != null) {
      ballNumberComponent!.text = "x$ballNumber";//in game screen Ball number print
    }
  }

  @override
  Future<void> update(double dt) async {
    final allPositionComponents = children.query<NewBall>();
    if (allPositionComponents.isEmpty && gameState == GameState.turning) {
      gameState = GameState.doneTurn;
    }

    if (gameState == GameState.doneTurn) {
      board!.moveBrick();
      board!.addRowBrick();
      gameState = GameState.start;
    }
    updateScore();
    updateBallNumber();
    super.update(dt);
  }

  @override
  void onLoad() async {
    initGame();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  void onTapUp(TapUpEvent event) async {
    if (gameState == GameState.start) {
      updateEndPoint(event.devicePosition.toOffset());
      targetPosition = event.devicePosition;
      isBuong = true;
      final allPositionComponents = children.query<NewBall>();
      if (allPositionComponents.isEmpty) {
        for (var i = 0; i < ballNumber; i++) {
          add(NewBall());
          await Future.delayed(const Duration(milliseconds: 500));//next ball delay time 
        }
        gameState = GameState.turning;
      }
    }

    super.onTapUp(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    updateEndPoint(event.deviceStartPosition.toOffset());
    targetPosition = event.deviceStartPosition;
  }

  @override
  void onDragEnd(DragEndEvent event) async {
    super.onDragEnd(event);
    if (gameState == GameState.start) {
      isBuong = true;
      final allPositionComponents = children.query<NewBall>();
      if (allPositionComponents.isEmpty) {
        for (var i = 0; i < ballNumber; i++) {
          add(NewBall());
          await Future.delayed(const Duration(milliseconds: 500));//next ball delay time
        }
        gameState = GameState.turning;
      }
    }
  }

  void updateEndPoint(Offset newPoint) {
    double angle =
        atan2(newPoint.dy - startPoint.dy, newPoint.dx - startPoint.dx);
    double length = 200;//aim line length
    endPoint = Offset(startPoint.dx + length * cos(angle),
        startPoint.dy + length * sin(angle));
  }
}

enum GameState { gameOver, doneTurn, turning, start }
