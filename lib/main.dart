import 'package:brick_balls_game/screens/providers/main_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/menu/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MainAppProvider(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen()));
  }
}
