import 'dart:async';
import 'package:brick_balls_game/screens/game_screen/game_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../menu/home_screen.dart';

class HomeButton extends SpriteComponent
    with TapCallbacks, HasGameRef<MainGame> {
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('home.png');
    size = Vector2.all(50);
    position = Vector2(30, 30);
    anchor = Anchor.center;
    priority = 1;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    Navigator.push(game.buildContext!,
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
