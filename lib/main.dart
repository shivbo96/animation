import 'package:animations/spring_animation_challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'elastic_effect_animation.dart';
import 'friction_simulation_animation.dart';
import 'gravity_simulation.dart';
import 'lamp_rope_animation.dart';
import 'rope_light_animation.dart';
import 'spring_simulation_2d.dart';
import 'spring_simulation_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        ListTile(
            title: const Text('Gravity Simulation Animation'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const GravitySimulationAnimation()));
            }),
        ListTile(
            title: const Text('Spring Simulation Animation'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SpringSimulationAnimation()));
            }),
        ListTile(
            title: const Text('Friction Simulation Animation'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const FrictionSimulationAnimation()));
            }),
        ListTile(
            title: const Text('Spring Animation Challenge'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SpringAnimationChallenge()));
            }),
        ListTile(
            title: const Text('Spring 2D-Animation Challenge'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SpringSimulation2D()));
            }),

        ListTile(
            title: const Text('Rope Light Animation Challenge'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RopeLightAnimation()));
            }),

        ListTile(
            title: const Text('Lamp Rope Animation Challenge'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LampRopeAnimation()));
            }),

        ListTile(
            title: const Text('Elastic Effect Animation Challenge'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ElasticEffectAnimation()));
            }),
      ],
    )));
  }
}

