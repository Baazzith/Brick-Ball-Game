import 'package:brick_balls_game/screens/providers/main_app_provider.dart';
import 'package:brick_balls_game/configs/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'primary_background.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PrimaryBackground(
          child: Stack(
            children: [
              Transform.translate(
                offset: const Offset(0, 155),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "SETTINGS",
                    style: style.copyWith(fontSize: 36),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Transform.translate(
                offset: const Offset(0, -50),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.read<MainAppProvider>().turnOnVibration();
                          },
                          child:
                              context.watch<MainAppProvider>().isVibratonTurnOn
                                  ? Image.asset("assets/images/vibration.png")
                                  : Image.asset(
                                      "assets/images/vibration_grey.png")),
                      const SizedBox(width: 5),
                      GestureDetector(
                          onTap: () {
                            context.read<MainAppProvider>().turnOffVibration();
                          },
                          child:
                              context.watch<MainAppProvider>().isVibratonTurnOn
                                  ? Image.asset("assets/images/unvibration.png")
                                  : Image.asset(
                                      "assets/images/unvibration_grey.png"))
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 80),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.read<MainAppProvider>().turnOnSound();
                          },
                          child: context.watch<MainAppProvider>().isSoundTurnOn
                              ? Image.asset(
                                  "assets/images/music_on_grey.png",
                                )
                              : Image.asset(
                                  "assets/images/music_on.png",
                                )),
                      const SizedBox(width: 5),
                      GestureDetector(
                          onTap: () {
                            context.read<MainAppProvider>().turnOffSound();
                          },
                          child: context.watch<MainAppProvider>().isSoundTurnOn
                              ? Image.asset("assets/images/music_off_grey.png")
                              : Image.asset("assets/images/music_off.png"))
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -80),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/back_btn.png')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
