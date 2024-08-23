import 'package:flutter/material.dart';

class CourseInputWidget extends StatelessWidget {
  final int numCourses;
  final List<ValueChanged<int?>> onCreditChanged;
  final List<ValueChanged<String?>> onGradeChanged;

  const CourseInputWidget({
    Key? key,
    required this.numCourses,
    required this.onCreditChanged,
    required this.onGradeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(numCourses, (index) {
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Credits',
                  border: OutlineInputBorder(),
                ),
                items: [1, 2, 3, 4, 5, 6]
                    .map((credit) => DropdownMenuItem(
                          value: credit,
                          child: Text(credit.toString()),
                        ))
                    .toList(),
                onChanged: onCreditChanged[index],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Grade',
                  border: OutlineInputBorder(),
                ),
                items: ['S', 'A', 'B', 'C', 'D', 'E', 'F']
                    .map((grade) => DropdownMenuItem(
                          value: grade,
                          child: Text(grade),
                        ))
                    .toList(),
                onChanged: onGradeChanged[index],
              ),
            ),
          ],
        );
      }),
    );
  }
}
