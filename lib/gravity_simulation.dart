import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class GravitySimulationAnimation extends StatefulWidget {
  const GravitySimulationAnimation({Key? key}) : super(key: key);

  @override
  State<GravitySimulationAnimation> createState() => _GravitySimulationAnimationState();
}

class _GravitySimulationAnimationState extends State<GravitySimulationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this);
    _animation = _animationController.drive(
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomCenter));

    _animationController.addListener(() {
      debugPrint('value is ${_animationController.value}');
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
                  Expanded(
                    child: AnimatedBuilder(
                        animation: _animation,
                        child: Container(height: 20, width: 20, color: Colors.red),
                        builder: (context, child) {
                          return Align(alignment: _animation.value, child: child);
                        }),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      filledColorButton(
                          onPressed: () {
                            _animationController.animateWith(GravitySimulation(
                              0.01,
                              0,
                              1,
                              0.01,
                            ));
                          },
                          text: 'Start'),
                      filledColorButton(onPressed: () {
                        _animationController.stop();
                      }, text: 'stop'),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              )),
        ));
  }

}


Widget filledColorButton(
    {required String text, required Function() onPressed, Color? color}) {
  final primaryColor = color ??= Colors.blue;
  return OutlinedButton(
    style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        alignment: Alignment.center,
        side: MaterialStateProperty.all(
            BorderSide(width: 1, color: primaryColor)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10)),
        backgroundColor: MaterialStateProperty.all(primaryColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)))),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 17),
    ),
  );
}