import 'package:flutter/material.dart';
import 'package:microit_app/model/faculty_model.dart';

class FacultyCard extends StatelessWidget {
  const FacultyCard({super.key, required this.faculty});
  final FacultyModel faculty;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 178, 190, 181),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(faculty.image),
              backgroundColor: Colors
                  .white, // Ensuring a background color to handle transparency
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              faculty.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(faculty.cabin),
            const SizedBox(
              height: 5,
            ),
            Text(faculty.school),
          ],
        ),
      ),
    );
  }
}
