import 'package:flutter/material.dart';

class DeviceSize {
  static width(context, {int partNumber = 10}) {
    return MediaQuery.of(context).size.width * partNumber / 10;
  }

  static height(context, {int partNumber = 10}) {
    return MediaQuery.of(context).size.height * partNumber / 10;
  }
}
