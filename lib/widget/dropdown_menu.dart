import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatelessWidget {
  final int selectedNumber2;
  final ValueChanged<int?> onChanged;

  const DropdownMenuWidget(
      {Key? key, required this.selectedNumber2, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: selectedNumber2,
      decoration: const InputDecoration(
        labelText: 'No. of courses',
        border: OutlineInputBorder(),
      ),
      items: List.generate(10, (index) => index + 1)
          .map((number) => DropdownMenuItem(
                value: number,
                child: Text(number.toString()),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
