import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'gravity_simulation.dart';

class SpringSimulationAnimation extends StatefulWidget {
  const SpringSimulationAnimation({Key? key}) : super(key: key);

  @override
  State<SpringSimulationAnimation> createState() =>
      _SpringSimulationAnimationState();
}

class _SpringSimulationAnimationState extends State<SpringSimulationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController.unbounded(vsync: this);
    _animation = _animationController.drive(
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.center));

    _animationController.addListener(() {
      debugPrint('controller value ${_animationController.value}');
      debugPrint('animation value ${_animation.value}');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        children: [
          const SizedBox(height: 50),
          Expanded(child: AnimatedBuilder(animation: _animation,builder: (BuildContext context, Widget? child) {
            return Align(alignment: _animation.value,child: child);
          },
          child: Container(height: 20, width: 20, color: Colors.red))),
          const SizedBox(height: 50),
          filledColorButton(
              text: 'Start',
              onPressed: () {
                _animationController.animateWith(SpringSimulation(
                  const SpringDescription(damping: 0.7, mass: 1, stiffness: 2),
                  0,
                  1,
                  0,
                ));
              }),
          const SizedBox(height: 50),
        ],
      )),
    ));
  }
}
