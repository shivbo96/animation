import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'gravity_simulation.dart';

class FrictionSimulationAnimation extends StatefulWidget {
  const FrictionSimulationAnimation({Key? key}) : super(key: key);

  @override
  State<FrictionSimulationAnimation> createState() =>
      _FrictionSimulationAnimationState();
}

class _FrictionSimulationAnimationState
    extends State<FrictionSimulationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController.unbounded(vsync: this);
    _animation = _animationController.drive(AlignmentTween(
        begin: Alignment.centerLeft, end: Alignment.centerRight));

    _animationController.addListener(() {
      debugPrint('_animationController value ${_animationController.value}');
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              builder: (context, child) {
                return Align(alignment: _animation.value, child: child);
              },
              animation: _animation,
              child: Container(height: 20, width: 20, color: Colors.red)),
          Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Colors.black),
          const SizedBox(height: 50),
          filledColorButton(
              onPressed: () {
                /// [without through]
                /*_animationController.animateWith(FrictionSimulation(
                  0.1,
                  0,
                  1,
                ));*/

                /// [with through constructor]

                /* _animationController.animateWith(FrictionSimulation.through(
                  0,
                  1,
                  1,
                  0.1,
                ));*/

                /// [with Bounded FrictionSimulation]

                _animationController.animateWith(BoundedFrictionSimulation(
                  0.4,
                  0.01,
                  1,
                  -0.1,
                  1,
                ));
              },
              text: 'start'),
          filledColorButton(
              onPressed: () {
                _animationController.stop();
              },
              text: 'stop'),
        ],
      )),
    ));
  }
}
