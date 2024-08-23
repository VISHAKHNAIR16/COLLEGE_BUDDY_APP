import 'package:flutter/material.dart';

class GradeInput extends StatelessWidget {
  final int index;
  final int? selectedCredits; // To hold the currently selected credits
  final double? selectedGrade; // To hold the currently selected grade
  final ValueChanged<int?> onCreditChanged;
  final ValueChanged<double?> onGradeChanged;

  const GradeInput(
      {required this.index,
      this.selectedCredits,
      this.selectedGrade,
      required this.onCreditChanged,
      required this.onGradeChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Course ${index + 1}: '),
        Expanded(
          child: DropdownButton<int?>(
            value: selectedCredits,
            items: [1, 2, 3, 4].map((int value) {
              return DropdownMenuItem<int?>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (int? newValue) {
              onCreditChanged(newValue);
            },
          ),
        ),
        Expanded(
          child: DropdownButton<double?>(
            value: selectedGrade,
            items: const [
              DropdownMenuItem<double?>(
                value: 10.0,
                child: Text('S'),
              ),
              DropdownMenuItem<double?>(
                value: 9.0,
                child: Text('A'),
              ),
              DropdownMenuItem<double?>(
                value: 8.0,
                child: Text('B'),
              ),
              DropdownMenuItem<double?>(
                value: 7.0,
                child: Text('C'),
              ),
              DropdownMenuItem<double?>(
                value: 6.0,
                child: Text('D'),
              ),
              DropdownMenuItem<double?>(
                value: 5.0,
                child: Text('E'),
              ),
              DropdownMenuItem<double?>(
                value: 0.0,
                child: Text('F'),
              ),
            ],
            onChanged: (double? newValue) {
              onGradeChanged(newValue);
            },
          ),
        ),
      ],
    );
  }
}
