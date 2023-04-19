import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class SpringAnimationChallenge extends StatefulWidget {
  const SpringAnimationChallenge({Key? key}) : super(key: key);

  @override
  State<SpringAnimationChallenge> createState() =>
      _SpringAnimationChallengeState();
}

class _SpringAnimationChallengeState extends State<SpringAnimationChallenge>
    with TickerProviderStateMixin {
  Offset _offset = const Offset(0, 0);

  final _springDescription = const SpringDescription(
    mass: 1,
    stiffness: 500,
    /// use stiff 100 when you want drag the ball and want that ball come to center only
    damping: 15,
  );

  late SpringSimulation _springSimulation;
  Ticker? _ticker;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += Offset(0, details.delta.dy);
    });
  }

  void _onPanStart(DragStartDetails details) {
    _endSpring();
  }

  void _onPanEnd(DragEndDetails details) {
    _startSpring();
  }

  _startSpring() {
    _springSimulation = SpringSimulation(_springDescription, _offset.dy, 0, 0);

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
      _offset = Offset(_offset.dx, _springSimulation.x(elapsedTimeFraction));
    });
    if (_springSimulation.isDone(elapsedTimeFraction)) {
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
    // return SizedBox.expand(child: Image.asset('assets/night.jpg'));
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

class WebPainter extends CustomPainter {
  Offset springOffset;
  final Paint springPaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;

  WebPainter({this.springOffset = const Offset(0, 0)});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    canvas.drawLine(center, center + springOffset, springPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
