import 'dart:math';

import 'package:flutter/material.dart';
import 'package:microit_app/screen/home_screen.dart';

class AboutusScreen extends StatefulWidget {
  const AboutusScreen({super.key});

  @override
  State<AboutusScreen> createState() {
    return _AboutusScreenState();
  }
}

class _AboutusScreenState extends State<AboutusScreen> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 26, 96, 66),
                Color.fromARGB(255, 93, 182, 144),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
          ),
          SafeArea(
            child: Container(
              width: 200.0,
              padding: const EdgeInsets.all(8.0),
              child: const Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: AssetImage("assets/images/LOGO.png"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Text(
                      "ABOUT US WEASNFBDVHIBDDVJNJABBIVNSDJCBHBCNSDHVDNCNSHCBIANDO JIDDGUSJOFHYHUONJSDYH")
                ],
              ),
            ),
          ),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: const Duration(milliseconds: 500),
              builder: (_, double val, __) {
                return (Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 6) * val),
                  child: const HomeScreen() // Scaffold
                  ,
                ));
              }),
          GestureDetector(onHorizontalDragUpdate: (e) {
            if (e.delta.dx > 0) {
              setState(() {
                value = 1;
              });
            } else {
              setState(() {
                value = 0;
              });
            }
          })
        ],
      ),
    );
  }
}
