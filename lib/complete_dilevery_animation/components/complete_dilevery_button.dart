import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/truck_animation.dart';

class DeliveredButton extends StatelessWidget {
  const DeliveredButton({
    super.key,
    required this.onTap
  });

  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    final truckAnimation = Get.put(TruckAnimation());
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
                        onTap: () {
                          onTap();
                          truckAnimation.animate();
                        },
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

class Truck extends StatelessWidget {
  const Truck({
    super.key,
    this.light = false,
    this.openDoors = false
  });

  final bool light,openDoors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedRotation(
                turns: openDoors ? 0.27 : 0,
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 500),
                child: SvgPicture.asset('assets/images/door1.svg')
              ),
              AnimatedRotation(
                turns: openDoors ? -0.27 : 0,
                alignment: Alignment.bottomCenter,
                duration: const Duration(milliseconds: 500),
                child: SvgPicture.asset('assets/images/door2.svg')
              )
            ],
          ),
          if (!light) 
            SvgPicture.asset('assets/images/truck.svg') 
          else 
            SvgPicture.asset('assets/images/truck_light.svg'),
        ],
      ),
    );
  }
}