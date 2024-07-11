import 'package:brick_balls_game/screens/game_screen/game_screen.dart';
import 'package:brick_balls_game/configs/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'instruction_screen.dart';
import 'primary_background.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PrimaryBackground(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Transform.translate(
              offset: const Offset(0, -30),
              child: Column(
                children: [
                  Transform.translate(
                      offset: const Offset(0, 20),
                      child: SvgPicture.asset('assets/images/ball.svg',
                          width: 50, height: 50)),
Text("BRICKs", style: style.copyWith(fontSize: 55)), // BRICKs on first line
                    SizedBox(height: 0), // Adjust spacing between lines if needed
                    Text("&", style: style.copyWith(fontSize: 64)), // "&" centered on second line
                    SizedBox(height: 0), // Adjust spacing between lines if needed
                    Text("BALLs", style: style.copyWith(fontSize: 55)), // BALLs on third line
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                  },
                  child: Image.asset('assets/images/setting_btn.png'),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InstructionScreen()));
                  },
                  child: Image.asset('assets/images/question_btn.png'),
                )
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameScreen()));
              },
              child: Image.asset('assets/images/play_btn.png'),
            )
          ]),
        ),
      ),
    );
  }
}
