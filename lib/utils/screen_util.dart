import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

final scaler = ScreenScaler();
final ss = scaler;

bool _scalerInitialized = false;
bool get scalerInitialized => _scalerInitialized;

void initializeScaler(BuildContext context) {
  scaler.init(context);
  _scalerInitialized = true;
}

extension ScreenScalerPercentages on int {
  double get w => scaler.getWidth(this.toDouble());
  double get h => scaler.getHeight(this.toDouble());
  double get f => scaler.getTextSize(this.toDouble());
}

extension ScreenScalerPercentagesDouble on double {
  double get w => scaler.getWidth(this);
  double get h => scaler.getHeight(this);
  double get f => scaler.getTextSize(this);
}