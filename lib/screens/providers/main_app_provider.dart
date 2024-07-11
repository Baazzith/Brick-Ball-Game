import 'package:flutter/material.dart';

class MainAppProvider extends ChangeNotifier {
  bool isSoundTurnOn = true;
  bool isVibratonTurnOn = true;

  turnOffSound() {
    isSoundTurnOn = false;
    notifyListeners();
  }

  turnOnSound() {
    isSoundTurnOn = true;
    notifyListeners();
  }

  turnOnVibration() {
    isVibratonTurnOn = true;
    notifyListeners();
  }

  turnOffVibration() {
    isVibratonTurnOn = false;
    notifyListeners();
  }
}
