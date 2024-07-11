import 'dart:async';

import 'package:brick_balls_game/screens/game_screen/game_screen.dart';
import 'package:brick_balls_game/configs/styles.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BallNumberComponent extends TextComponent with HasGameRef<MainGame> {
  BallNumberComponent({required this.newSize})
      : super(
            text: "BALL NUMBER: \nx1",
            scale: Vector2.all(1),
            anchor: Anchor.center,
            position: Vector2(newSize.x - 50, newSize.y * 0.95));

  final Vector2 newSize;

  @override
  FutureOr<void> onLoad() {
    final newStyle = style.copyWith(fontSize: 20, color: Colors.black);
    final regular = TextPaint(style: newStyle);
    textRenderer = regular;
    return super.onLoad();
  }
}
