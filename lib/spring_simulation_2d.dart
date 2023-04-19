import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'spring_animation_challenge.dart';

class SpringSimulation2D extends StatefulWidget {
  const SpringSimulation2D({Key? key}) : super(key: key);

  @override
  State<SpringSimulation2D> createState() => _SpringSimulation2DState();
}

class _SpringSimulation2DState extends State<SpringSimulation2D>
    with TickerProviderStateMixin {
  Offset _offset = const Offset(0, 0);
  Offset previousVelocity = const Offset(0, 0);

  final _springDescription = const SpringDescription(
    mass: 1,
    stiffness: 500,

    /// use stiff 100 when you want drag the ball and want that ball come to center only
    damping: 15,
  );

  late SpringSimulation _springSimX;
  late SpringSimulation _springSimY;
  Ticker? _ticker;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += details.delta;
    });
  }

  void _onPanStart(DragStartDetails details) {
    _endSpring();
  }

  void _onPanEnd(DragEndDetails details) {
    _startSpring();
  }

  _startSpring() {
    _springSimX = SpringSimulation(
      _springDescription,
      _offset.dx,
      0,
      previousVelocity.dx,
    );

    _springSimY = SpringSimulation(
      _springDescription,
      _offset.dy,
      0,
      previousVelocity.dy,
    );

    _ticker ??= createTicker(_onTick);
    _ticker?.start();
  }

  _endSpring() {
    if (_ticker != null) {
      _ticker!.stop();
    }
  }

  _onTick(Duration elapsedTime) {
    final elapsedTimeFraction = elapsedTime.inMilliseconds / 1000.0;
    setState(() {
      _offset = Offset(_springSimX.x(elapsedTimeFraction),
          _springSimY.x(elapsedTimeFraction));

      previousVelocity = Offset(_springSimX.dx(elapsedTimeFraction),
          _springSimY.dx(elapsedTimeFraction));
    });
    if (_springSimX.isDone(elapsedTimeFraction) &&
        _springSimY.isDone(elapsedTimeFraction)) {
      _endSpring();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanEnd: _onPanEnd,
          onPanUpdate: _onPanUpdate,
          child: Stack(children: [
            _buildBackground(),
            CustomPaint(
                painter: WebPainter(springOffset: _offset),
                size: Size.infinite),
            Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: _offset,
                  child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle)),
                ))
          ]),
        ));
  }

  Widget _buildBackground() {
    return Image.asset(
      'assets/night.jpg',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black45,
      colorBlendMode: BlendMode.multiply,
    );
  }
}
