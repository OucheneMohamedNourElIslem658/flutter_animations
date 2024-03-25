import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

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