import 'package:flutter/material.dart';
import 'package:microit_app/widget/dropdown_menu.dart';
import 'package:microit_app/widget/course_input.dart';
import 'package:microit_app/widget/submit_button.dart';
import 'package:microit_app/appbar/curveappbar.dart';

class GpaCalculatorScreen extends StatefulWidget {
  const GpaCalculatorScreen({super.key});

  @override
  State<GpaCalculatorScreen> createState() {
    return _GpaCalculatorScreenState();
  }
}

class _GpaCalculatorScreenState extends State<GpaCalculatorScreen> {
  int _selectedNumber = 1;
  List<int?> _credits = [null];
  List<String?> _grades = [null];
  double _gpa = 0.0;

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
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 26, 96, 66),
                  width: 3.5,
                ),
              ),
            ),
            child: const Text(
              "GPA Calculator",
              style: TextStyle(
                fontSize: 50,
                color: Color.fromARGB(201, 0, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownMenuWidget(
                  selectedNumber2: _selectedNumber,
                  onChanged: (value) {
                    setState(() {
                      _selectedNumber = value!;
                      _credits = List<int?>.filled(value, null);
                      _grades = List<String?>.filled(value, null);
                    });
                  },
                ),
                const SizedBox(height: 20),
                CourseInputWidget(
                  numCourses: _selectedNumber,
                  onCreditChanged: List.generate(
                    _selectedNumber,
                    (index) => (value) => _credits[index] = value,
                  ),
                  onGradeChanged: List.generate(
                    _selectedNumber,
                    (index) => (value) => _grades[index] = value,
                  ),
                ),
                const SizedBox(height: 20),
                SubmitButtonWidget(
                  onPressed: _calculateGPA,
                  gpa: _gpa,
                ),
              ],
            ),
          ),
        ])));
  }

  void _calculateGPA() {
    double totalGradePoints = 0.0;
    double totalCredits = 0.0;

    for (int i = 0; i < _selectedNumber; i++) {
      if (_credits[i] != null && _grades[i] != null) {
        double gradePoint = _gradeToPoint(_grades[i]!);
        totalGradePoints += gradePoint * _credits[i]!;
        totalCredits += _credits[i]!;
      }
    }

    setState(() {
      if (totalCredits > 0) {
        _gpa = totalGradePoints / totalCredits;
      } else {
        _gpa = 0.0;
      }
    });
  }

  double _gradeToPoint(String grade) {
    switch (grade) {
      case 'S':
        return 10.0;
      case 'A':
        return 9.0;
      case 'B':
        return 8.0;
      case 'C':
        return 7.0;
      case 'D':
        return 6.0;
      case 'E':
        return 5.0;
      case 'F':
        return 0.0;
      default:
        return 0.0;
    }
  }
}
