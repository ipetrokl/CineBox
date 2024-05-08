import 'package:flutter/material.dart';

class ScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(97, 72, 199, 1)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height / 2);

    Offset controlPoint = Offset(size.width / 2, -18);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      size.width,
      size.height / 2,
    );

    // Crta crtu
    canvas.drawPath(path, paint);

    // Dodaje sjenu ispod crte
    canvas.drawShadow(path, Colors.black, 5.0, true);
    canvas.drawShadow(path, Colors.black, 5.0, true);
    canvas.drawShadow(path, Colors.black, 5.0, true);
    canvas.drawShadow(path, Colors.black, 10.0, true);
    canvas.drawShadow(path, Colors.black, 10.0, true);
    canvas.drawShadow(path, Colors.black, 15.0, true);
    canvas.drawShadow(path, Colors.black, 15.0, true);
    canvas.drawShadow(path, Colors.black, 15.0, true);
    canvas.drawShadow(path, Colors.black, 20.0, true);
    canvas.drawShadow(path, Colors.black, 20.0, true);
    canvas.drawShadow(path, Colors.black, 25.0, true);
    canvas.drawShadow(path, Colors.black, 25.0, true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}