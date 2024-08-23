import 'package:flutter/material.dart';

class HomeScreenBox extends StatelessWidget {
  const HomeScreenBox({super.key, required this.name, required this.iconPath});

  final String name;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              iconPath,
              height: 100,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
