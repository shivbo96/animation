
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class ElasticEffectAnimation extends StatelessWidget {
  const ElasticEffectAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 20.0,
          ),
          child: PhysicsBox(),
        ));
  }
}

class PhysicsBox extends StatefulWidget {
  const PhysicsBox({super.key});


  @override
  BoxState createState() => BoxState();
}

class BoxState extends State<PhysicsBox> with TickerProviderStateMixin {

  late AnimationController controller;
  late AnimationController controller2;
  late Animation<double> animation;
  late SpringSimulation simulation;
  double? _position;

  @override
  void dispose() {
    controller2.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    simulation = SpringSimulation(
      const SpringDescription(
        mass: 1.0,
        stiffness: 100.0,
        damping: 5.0,
      ),
      400.0,
      208.0,
      -4000.0,
    );

    controller2 = AnimationController(vsync: this,duration: const Duration(milliseconds: 70));
    animation = Tween(begin: 200.0, end: 400.0).animate(controller2)
      ..addListener((){
        if(controller2.status == AnimationStatus.completed){controller.reset();}
        setState(() {
          _position = animation.value;
        });
      });

    controller = AnimationController(vsync: this,duration: const Duration(milliseconds: 700))..forward()
      ..addListener(() {
        if(controller.status == AnimationStatus.completed){controller2.reset();}
        setState(() {
          _position = simulation.x(controller.value);
        });
        print('${simulation.x(controller.value)}');
      });
  }




  @override
  Widget build(BuildContext context) {



    return Center(
      child: Container(
          color: Colors.yellow,
          width:500.0,
          height:500.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: _position,
                // right: 0,
                left: 150,
                child: GestureDetector(
                  onTap: (){

                    if (controller.status == AnimationStatus.completed) {
                      controller2.forward();//controller.reset();
                    }else{

                      controller.forward();}
                  },
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}