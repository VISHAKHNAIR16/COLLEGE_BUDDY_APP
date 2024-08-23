import 'package:flutter/material.dart';
import 'package:microit_app/screen/gpa_calculator.dart';
import 'package:microit_app/appbar/curveappbar.dart';
import 'package:microit_app/screen/cgpa_calculator_screen.dart';

class GpaOrCgpa extends StatelessWidget {
  const GpaOrCgpa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: ClipPath(
          clipper: Curveappbar(),
          child: AppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/design.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to the GPA Calculator Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GpaCalculatorScreen()),
                );
              },
              child: const Text('GPA Calculator'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the CGPA Calculator Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CGPACalculator()),
                );
              },
              child: const Text('CGPA Calculator'),
            ),
          ],
        ),
      ),
    );
  }
}
