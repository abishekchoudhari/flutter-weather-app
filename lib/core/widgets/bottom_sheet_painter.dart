import 'package:flutter/material.dart';

class BottomSheetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const gradient = LinearGradient(
      colors: [
        Color.fromARGB(255, 88, 20, 223),
        Color.fromARGB(255, 177, 133, 190)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}