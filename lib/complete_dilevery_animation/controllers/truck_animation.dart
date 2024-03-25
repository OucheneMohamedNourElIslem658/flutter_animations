import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Translation {
  final Alignment alignment;
  final Duration duration;
  final Curve curve;

  const Translation({
    required this.alignment,
    required this.duration,
    this.curve = Curves.linear
  });
}

class OpenDoors {
  final double turns;
  final Duration duration;
  final Curve curve;

  const OpenDoors({
    required this.turns,
    required this.duration,
    this.curve = Curves.linear
  });
}

class TruckAnimation extends GetxController {
  var light = false;
  var openDoors = false;
  var showBox = true;
  var completed = false;
  var disableButton = false;
  var boxTranslation = const Translation(
    alignment: Alignment(-0.65, 0), 
    duration: Duration(milliseconds: 500),
  );

  double rudeLinesTranslation = -822;

  var truckTranslations = [
    const Translation(
      alignment: Alignment(0.2,0), 
      duration: Duration(milliseconds: 500)
    ),
    const Translation(
      alignment: Alignment(0.9,0), 
      duration: Duration(milliseconds: 1000)
    ),
    const Translation(
      alignment: Alignment(-0.75,0), 
      duration: Duration(milliseconds: 1000)
    ),
    const Translation(
      alignment: Alignment(2.7,0), 
      duration: Duration(milliseconds: 1000),
    )
  ];

  late Translation truckTranslation;

  @override
  void onInit() {
    truckTranslation = truckTranslations[0];
    super.onInit();
  }

  Future<void> packBox() async {
    openDoors = true;
    update();
    await Future.delayed(const Duration(milliseconds: 500));
    boxTranslation = const Translation(
      alignment: Alignment(-0.2, 0), 
      duration: Duration(milliseconds: 500)
    );
    update();
    await Future.delayed(boxTranslation.duration);
    showBox = false;
    openDoors = false;
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void animate() async {
    disableButton = true;
    update();
    for (var i = 0; i < truckTranslations.length; i++) {
      if (i == 0) {
        await packBox();
      }
      if (i == 1) {
        light = true;
        rudeLinesTranslation = 0;
      }
      truckTranslation = truckTranslations[i];
      update();
      await Future.delayed(truckTranslation.duration);
    }
    resetAnimation();
  }

  void resetAnimation() async {
    completed = true;
    update();
    disableButton = false;
    update();
    light = false;
    showBox = true;
    truckTranslation = truckTranslations[0];
    boxTranslation = const Translation(
      alignment: Alignment(-0.65, 0), 
      duration: Duration(milliseconds: 500)
    );
    rudeLinesTranslation = -822;
    update();
    await Future.delayed(const Duration(milliseconds: 2000));
    completed = false;
    update();
  }
}