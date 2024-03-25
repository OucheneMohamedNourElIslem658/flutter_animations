import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'components/truck.dart';
import 'controllers/truck_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}


class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final truckAnimation = Get.put(TruckAnimation());
    return Scaffold(
      body: Center(
        child: DeliveredButton(
          truckAnimation: truckAnimation
        ),
      ),
    );
  }
}

class DeliveredButton extends StatelessWidget {
  const DeliveredButton({
    super.key,
    required this.truckAnimation,
  });

  final TruckAnimation truckAnimation;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(220),
        child: Container(
          height: 220,
          width: 822,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color:Color(0xFF1B262F),
          ),
          child: GetBuilder<TruckAnimation>(
            builder: (_) {
              if (truckAnimation.completed && !truckAnimation.disableButton) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Order Placed',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'TacticSans',
                        fontSize: 36
                      ),
                    ),
                    const SizedBox(width: 20),
                    SvgPicture.asset('assets/images/checked.svg')
                  ],
                );
              } else {
                return Stack(
                  children: [
                    AnimatedPositioned(
                      left: -(truckAnimation.rudeLinesTranslation),
                      top: 0,
                      bottom: 0,
                      duration: const Duration(seconds: 2),
                      child: SvgPicture.asset(
                        'assets/images/rude_lines.svg',
                      ),
                    ),
                    truckAnimation.showBox
                    ? AnimatedAlign(
                      alignment: truckAnimation.boxTranslation.alignment,
                      duration: truckAnimation.boxTranslation.duration,
                      curve: truckAnimation.boxTranslation.curve,
                      child: SvgPicture.asset('assets/images/box.svg')
                    )
                    : const SizedBox(),
                    AnimatedAlign(
                      alignment: truckAnimation.truckTranslation.alignment,
                      duration: truckAnimation.truckTranslation.duration,
                      curve: truckAnimation.truckTranslation.curve,
                      child: Truck(
                        light: truckAnimation.light,
                        openDoors: truckAnimation.openDoors,
                      )
                    ),
                    !truckAnimation.disableButton
                    ? Positioned.fill(
                      child: GestureDetector(
                        onTap: () => truckAnimation.animate(),
                        child: Container(
                          color:const Color(0xFF1B262F),
                          alignment: Alignment.center,
                          child: const Text(
                            'Complete',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'TacticSans',
                              fontSize: 36
                            ),
                          ),
                        ),
                      )
                    )
                    : const SizedBox(),
                  ],
                );
              }
            }
          ),
        ),
      ),
    );
  }
}