import 'package:flutter/material.dart';

class Curveappbar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 5, size.height / 2.5, size.width / 2, size.height - 50);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height, size.width, size.height - 50);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
