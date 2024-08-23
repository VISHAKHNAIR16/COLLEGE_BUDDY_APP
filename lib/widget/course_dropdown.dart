import 'package:flutter/material.dart';

class CourseDropdown extends StatelessWidget {
  final int currentValue; // Added to track the current selection
  final ValueChanged<int> onChanged;

  const CourseDropdown(
      {required this.currentValue, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Number of Courses: '),
        Expanded(
          child: DropdownButton<int>(
            value: currentValue, // Set the current value
            items: [
              1,
              2,
              3,
              4,
              5,
              6,
              7,
              8,
              9,
            ].map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (int? newValue) {
              if (newValue != null) {
                onChanged(newValue); // Ensure the value is not null
              }
            },
          ),
        ),
      ],
    );
  }
}
