import 'package:flutter/material.dart';
import 'package:microit_app/widget/current_cgpa.dart';
import 'package:microit_app/widget/total_credits.dart';
import 'package:microit_app/widget/course_input.dart';
import 'package:microit_app/widget/submit_cgpa_button.dart';
import 'package:microit_app/widget/dropdown_menu.dart';

class CGPACalculator extends StatefulWidget {
  const CGPACalculator({super.key});
  @override
  CGPACalculatorState createState() => CGPACalculatorState();
}

class CGPACalculatorState extends State<CGPACalculator> {
  double currentCGPA = 0.0;
  int totalCredits = 0;
  int numberOfCourses = 1;
  List<int> courseCredits = [];
  List<double> courseGrades = [];
  double predictedCGPA = 0.0;
  int _selectedNumber2 = 1;
  List<int?> _credits = [null];
  List<String?> _grades = [null];

  void calculateCGPA() {
    double totalGradePoints = currentCGPA * totalCredits;
    int newTotalCredits = totalCredits;

    for (int i = 0; i < numberOfCourses; i++) {
      if (i < courseCredits.length && i < courseGrades.length) {
        totalGradePoints += courseCredits[i] * courseGrades[i];
        newTotalCredits += courseCredits[i];
      }
    }

    setState(() {
      predictedCGPA =
          newTotalCredits > 0 ? totalGradePoints / newTotalCredits : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CGPA Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CurrentCGPA(
              onChanged: (value) {
                setState(() {
                  currentCGPA = value;
                });
              },
            ),
            TotalCredits(
              onChanged: (value) {
                setState(() {
                  totalCredits = value;
                  _selectedNumber2 = value;
                  _credits = List<int?>.filled(value, null);
                  _grades = List<String?>.filled(value, null);
                });
              },
            ),
            const SizedBox(height: 25),
            DropdownMenuWidget(
              selectedNumber2: _selectedNumber2,
              onChanged: (value) {
                setState(() {
                  _selectedNumber2 = value!;
                  _credits = List<int?>.filled(value, null);
                  _grades = List<String?>.filled(value, null);
                });
              },
            ),
            const SizedBox(height: 20),
            CourseInputWidget(
              numCourses: _selectedNumber2,
              onCreditChanged: List.generate(
                _selectedNumber2,
                (index) => (value) => _credits[index] = value,
              ),
              onGradeChanged: List.generate(
                _selectedNumber2,
                (index) => (value) => _grades[index] = value,
              ),
            ),
            SubmitButton(
              onPressed: calculateCGPA,
            ),
            Text(
              'Your CGPA is: ${predictedCGPA.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
