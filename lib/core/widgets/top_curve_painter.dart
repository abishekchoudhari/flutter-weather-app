import 'package:flutter/material.dart';

class TopCurvePainter extends CustomPainter {
  final BuildContext context;
  const TopCurvePainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 0.0;
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Path path = Path();

    if (MediaQuery.of(context).size.width < 600) {
      radius = 70.0;
      path.moveTo(0, size.height - 80); // Start point of the curve
      path.quadraticBezierTo(
          size.width / 2, size.height - 10, size.width, size.height - 80);
    } else {
      radius = 110.0;
      path.moveTo(0, size.height - 130); // Start point of the curve
      path.quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 130); // Curve
    }

    canvas.drawPath(path, paint);

    final Rect circleRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height), radius: radius - 10);
    const Gradient gradient = RadialGradient(
      radius: 0.8,
      colors: <Color>[
        Color.fromARGB(255, 88, 20, 223),
        Color.fromARGB(255, 177, 133, 190)
      ],
      stops: [0.5, 1.0],
    );

    final Paint paint1 = Paint()
      ..shader = gradient.createShader(circleRect)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height), radius, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
