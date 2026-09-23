import 'dart:math' as math;
import 'package:flutter/material.dart';

class TemplateOutlineWidget extends StatelessWidget {
  final String templateId;
  final Color outlineColor;
  final double strokeWidth;
  final bool fillShapes;

  const TemplateOutlineWidget({
    super.key,
    required this.templateId,
    this.outlineColor = const Color(0xFF2D251E),
    this.strokeWidth = 4.0,
    this.fillShapes = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TemplatePainter(
        templateId: templateId,
        outlineColor: outlineColor,
        strokeWidth: strokeWidth,
        fillShapes: fillShapes,
      ),
      size: Size.infinite,
    );
  }
}

class TemplatePainter extends CustomPainter {
  final String templateId;
  final Color outlineColor;
  final double strokeWidth;
  final bool fillShapes;

  TemplatePainter({
    required this.templateId,
    this.outlineColor = const Color(0xFF2D251E),
    this.strokeWidth = 4.0,
    this.fillShapes = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (templateId == 'blank') {
      _paintBlankCanvas(canvas, size);
      return;
    }

    final strokePaint = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillWhite = Paint()
      ..color = fillShapes ? Colors.white : Colors.transparent
      ..style = PaintingStyle.fill;

    switch (templateId) {
      case 'lion':
        _paintLion(canvas, size, strokePaint, fillWhite);
        break;
      case 'elephant':
        _paintElephant(canvas, size, strokePaint, fillWhite);
        break;
      case 'giraffe':
        _paintGiraffe(canvas, size, strokePaint, fillWhite);
        break;
      case 'puppy':
        _paintPuppy(canvas, size, strokePaint, fillWhite);
        break;
      case 'kitten':
        _paintKitten(canvas, size, strokePaint, fillWhite);
        break;
      case 'rocket':
        _paintRocket(canvas, size, strokePaint, fillWhite);
        break;
      case 'alien':
        _paintAlien(canvas, size, strokePaint, fillWhite);
        break;
      case 'dolphin':
        _paintDolphin(canvas, size, strokePaint, fillWhite);
        break;
      case 'turtle':
        _paintTurtle(canvas, size, strokePaint, fillWhite);
        break;
      case 'dino':
        _paintDino(canvas, size, strokePaint, fillWhite);
        break;
      case 'butterfly':
        _paintButterfly(canvas, size, strokePaint, fillWhite);
        break;
      case 'rainbow':
        _paintRainbow(canvas, size, strokePaint, fillWhite);
        break;
      default:
        _paintLion(canvas, size, strokePaint, fillWhite);
    }
  }

  // --- LION ---
  void _paintLion(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.48);
    final headRadius = math.min(w, h) * 0.22;

    // Mane petals
    final manePath = Path();
    const petalCount = 14;
    final outerManeRadius = headRadius * 1.55;
    for (int i = 0; i < petalCount; i++) {
      final angle = (i * 2 * math.pi) / petalCount;
      final nextAngle = ((i + 1) * 2 * math.pi) / petalCount;
      final midAngle = (angle + nextAngle) / 2;

      final p1 = Offset(
        center.dx + headRadius * 1.1 * math.cos(angle),
        center.dy + headRadius * 1.1 * math.sin(angle),
      );
      final pTip = Offset(
        center.dx + outerManeRadius * math.cos(midAngle),
        center.dy + outerManeRadius * math.sin(midAngle),
      );
      final p2 = Offset(
        center.dx + headRadius * 1.1 * math.cos(nextAngle),
        center.dy + headRadius * 1.1 * math.sin(nextAngle),
      );

      if (i == 0) manePath.moveTo(p1.dx, p1.dy);
      manePath.quadraticBezierTo(pTip.dx, pTip.dy, p2.dx, p2.dy);
    }
    manePath.close();
    canvas.drawPath(manePath, fill);
    canvas.drawPath(manePath, stroke);

    // Body
    final bodyPath = Path()
      ..moveTo(w * 0.35, h * 0.65)
      ..quadraticBezierTo(w * 0.28, h * 0.90, w * 0.38, h * 0.92)
      ..lineTo(w * 0.62, h * 0.92)
      ..quadraticBezierTo(w * 0.72, h * 0.90, w * 0.65, h * 0.65);
    canvas.drawPath(bodyPath, fill);
    canvas.drawPath(bodyPath, stroke);

    // Paws
    canvas.drawCircle(Offset(w * 0.42, h * 0.88), w * 0.06, fill);
    canvas.drawCircle(Offset(w * 0.42, h * 0.88), w * 0.06, stroke);
    canvas.drawCircle(Offset(w * 0.58, h * 0.88), w * 0.06, fill);
    canvas.drawCircle(Offset(w * 0.58, h * 0.88), w * 0.06, stroke);

    // Head base
    canvas.drawCircle(center, headRadius, fill);
    canvas.drawCircle(center, headRadius, stroke);

    // Ears
    final earRadius = headRadius * 0.35;
    final leftEarCenter = Offset(center.dx - headRadius * 0.75, center.dy - headRadius * 0.75);
    final rightEarCenter = Offset(center.dx + headRadius * 0.75, center.dy - headRadius * 0.75);
    canvas.drawCircle(leftEarCenter, earRadius, fill);
    canvas.drawCircle(leftEarCenter, earRadius, stroke);
    canvas.drawCircle(leftEarCenter, earRadius * 0.5, stroke);
    canvas.drawCircle(rightEarCenter, earRadius, fill);
    canvas.drawCircle(rightEarCenter, earRadius, stroke);
    canvas.drawCircle(rightEarCenter, earRadius * 0.5, stroke);

    // Eyes
    final eyePaint = Paint()..color = outlineColor..style = PaintingStyle.fill;
    final leftEye = Offset(center.dx - headRadius * 0.38, center.dy - headRadius * 0.12);
    final rightEye = Offset(center.dx + headRadius * 0.38, center.dy - headRadius * 0.12);
    canvas.drawCircle(leftEye, headRadius * 0.12, eyePaint);
    canvas.drawCircle(rightEye, headRadius * 0.12, eyePaint);
    // Eye shines
    final shinePaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    canvas.drawCircle(leftEye + const Offset(-2, -2), headRadius * 0.04, shinePaint);
    canvas.drawCircle(rightEye + const Offset(-2, -2), headRadius * 0.04, shinePaint);

    // Nose
    final noseCenter = Offset(center.dx, center.dy + headRadius * 0.18);
    final nosePath = Path()
      ..moveTo(noseCenter.dx - headRadius * 0.22, noseCenter.dy - headRadius * 0.1)
      ..lineTo(noseCenter.dx + headRadius * 0.22, noseCenter.dy - headRadius * 0.1)
      ..quadraticBezierTo(noseCenter.dx, noseCenter.dy + headRadius * 0.18, noseCenter.dx - headRadius * 0.22, noseCenter.dy - headRadius * 0.1);
    canvas.drawPath(nosePath, stroke);

    // Smile
    final smilePath = Path()
      ..moveTo(noseCenter.dx, noseCenter.dy + headRadius * 0.1)
      ..lineTo(noseCenter.dx, noseCenter.dy + headRadius * 0.25)
      ..moveTo(noseCenter.dx - headRadius * 0.28, noseCenter.dy + headRadius * 0.35)
      ..quadraticBezierTo(noseCenter.dx - headRadius * 0.12, noseCenter.dy + headRadius * 0.48, noseCenter.dx, noseCenter.dy + headRadius * 0.25)
      ..quadraticBezierTo(noseCenter.dx + headRadius * 0.12, noseCenter.dy + headRadius * 0.48, noseCenter.dx + headRadius * 0.28, noseCenter.dy + headRadius * 0.35);
    canvas.drawPath(smilePath, stroke);

    // Whiskers
    canvas.drawLine(Offset(center.dx - headRadius * 0.4, center.dy + headRadius * 0.25), Offset(center.dx - headRadius * 0.85, center.dy + headRadius * 0.2), stroke);
    canvas.drawLine(Offset(center.dx - headRadius * 0.4, center.dy + headRadius * 0.35), Offset(center.dx - headRadius * 0.82, center.dy + headRadius * 0.38), stroke);
    canvas.drawLine(Offset(center.dx + headRadius * 0.4, center.dy + headRadius * 0.25), Offset(center.dx + headRadius * 0.85, center.dy + headRadius * 0.2), stroke);
    canvas.drawLine(Offset(center.dx + headRadius * 0.4, center.dy + headRadius * 0.35), Offset(center.dx + headRadius * 0.82, center.dy + headRadius * 0.38), stroke);
  }

  // --- ELEPHANT ---
  void _paintElephant(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.42);

    // Left Ear
    final leftEar = Path()
      ..moveTo(w * 0.35, h * 0.35)
      ..cubicTo(w * 0.08, h * 0.18, w * 0.08, h * 0.65, w * 0.32, h * 0.55);
    canvas.drawPath(leftEar, fill);
    canvas.drawPath(leftEar, stroke);

    // Right Ear
    final rightEar = Path()
      ..moveTo(w * 0.65, h * 0.35)
      ..cubicTo(w * 0.92, h * 0.18, w * 0.92, h * 0.65, w * 0.68, h * 0.55);
    canvas.drawPath(rightEar, fill);
    canvas.drawPath(rightEar, stroke);

    // Body
    final body = Path()
      ..moveTo(w * 0.32, h * 0.55)
      ..quadraticBezierTo(w * 0.25, h * 0.88, w * 0.40, h * 0.90)
      ..lineTo(w * 0.60, h * 0.90)
      ..quadraticBezierTo(w * 0.75, h * 0.88, w * 0.68, h * 0.55);
    canvas.drawPath(body, fill);
    canvas.drawPath(body, stroke);

    // Head
    canvas.drawCircle(center, w * 0.22, fill);
    canvas.drawCircle(center, w * 0.22, stroke);

    // Trunk
    final trunk = Path()
      ..moveTo(w * 0.44, h * 0.46)
      ..cubicTo(w * 0.42, h * 0.70, w * 0.38, h * 0.78, w * 0.50, h * 0.76)
      ..cubicTo(w * 0.60, h * 0.74, w * 0.58, h * 0.62, w * 0.55, h * 0.64)
      ..cubicTo(w * 0.50, h * 0.66, w * 0.48, h * 0.60, w * 0.56, h * 0.46);
    canvas.drawPath(trunk, fill);
    canvas.drawPath(trunk, stroke);

    // Eyes
    final eyePaint = Paint()..color = outlineColor..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.40, h * 0.36), w * 0.03, eyePaint);
    canvas.drawCircle(Offset(w * 0.60, h * 0.36), w * 0.03, eyePaint);
    canvas.drawCircle(Offset(w * 0.39, h * 0.35), w * 0.01, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.59, h * 0.35), w * 0.01, Paint()..color = Colors.white);
  }

  // --- GIRAFFE ---
  void _paintGiraffe(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Body
    final body = Path()
      ..moveTo(w * 0.35, h * 0.65)
      ..quadraticBezierTo(w * 0.20, h * 0.88, w * 0.42, h * 0.90)
      ..lineTo(w * 0.68, h * 0.90)
      ..quadraticBezierTo(w * 0.82, h * 0.85, w * 0.65, h * 0.65);
    canvas.drawPath(body, fill);
    canvas.drawPath(body, stroke);

    // Long Neck
    final neck = Path()
      ..moveTo(w * 0.42, h * 0.66)
      ..lineTo(w * 0.46, h * 0.28)
      ..lineTo(w * 0.56, h * 0.28)
      ..lineTo(w * 0.58, h * 0.66);
    canvas.drawPath(neck, fill);
    canvas.drawPath(neck, stroke);

    // Spots on Neck
    canvas.drawCircle(Offset(w * 0.50, h * 0.40), w * 0.035, stroke);
    canvas.drawCircle(Offset(w * 0.52, h * 0.52), w * 0.045, stroke);
    canvas.drawCircle(Offset(w * 0.48, h * 0.62), w * 0.04, stroke);

    // Head
    final head = Path()
      ..moveTo(w * 0.44, h * 0.28)
      ..cubicTo(w * 0.36, h * 0.24, w * 0.38, h * 0.14, w * 0.52, h * 0.14)
      ..cubicTo(w * 0.65, h * 0.14, w * 0.66, h * 0.24, w * 0.58, h * 0.28)
      ..close();
    canvas.drawPath(head, fill);
    canvas.drawPath(head, stroke);

    // Horns / Ossicones
    canvas.drawLine(Offset(w * 0.47, h * 0.14), Offset(w * 0.45, h * 0.08), stroke);
    canvas.drawCircle(Offset(w * 0.45, h * 0.08), w * 0.02, stroke);
    canvas.drawLine(Offset(w * 0.55, h * 0.14), Offset(w * 0.57, h * 0.08), stroke);
    canvas.drawCircle(Offset(w * 0.57, h * 0.08), w * 0.02, stroke);

    // Snout
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.51, h * 0.24), width: w * 0.14, height: h * 0.07), stroke);
    canvas.drawCircle(Offset(w * 0.48, h * 0.24), 2.5, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.54, h * 0.24), 2.5, Paint()..color = outlineColor);

    // Eyes
    canvas.drawCircle(Offset(w * 0.46, h * 0.18), w * 0.025, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.56, h * 0.18), w * 0.025, Paint()..color = outlineColor);
  }

  // --- PUPPY ---
  void _paintPuppy(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Body
    final body = Path()
      ..moveTo(w * 0.32, h * 0.62)
      ..quadraticBezierTo(w * 0.22, h * 0.90, w * 0.45, h * 0.92)
      ..lineTo(w * 0.60, h * 0.92)
      ..quadraticBezierTo(w * 0.78, h * 0.90, w * 0.68, h * 0.62);
    canvas.drawPath(body, fill);
    canvas.drawPath(body, stroke);

    // Floppy Left Ear
    final leftEar = Path()
      ..moveTo(w * 0.35, h * 0.32)
      ..cubicTo(w * 0.15, h * 0.32, w * 0.18, h * 0.58, w * 0.32, h * 0.50);
    canvas.drawPath(leftEar, fill);
    canvas.drawPath(leftEar, stroke);

    // Floppy Right Ear
    final rightEar = Path()
      ..moveTo(w * 0.65, h * 0.32)
      ..cubicTo(w * 0.85, h * 0.32, w * 0.82, h * 0.58, w * 0.68, h * 0.50);
    canvas.drawPath(rightEar, fill);
    canvas.drawPath(rightEar, stroke);

    // Head
    canvas.drawCircle(Offset(w * 0.5, h * 0.40), w * 0.22, fill);
    canvas.drawCircle(Offset(w * 0.5, h * 0.40), w * 0.22, stroke);

    // Eyes
    canvas.drawCircle(Offset(w * 0.41, h * 0.35), w * 0.035, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.59, h * 0.35), w * 0.035, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.40, h * 0.34), w * 0.012, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.58, h * 0.34), w * 0.012, Paint()..color = Colors.white);

    // Nose
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.5, h * 0.44), width: w * 0.09, height: h * 0.04), Paint()..color = outlineColor);

    // Tongue & Smile
    final smile = Path()
      ..moveTo(w * 0.42, h * 0.48)
      ..quadraticBezierTo(w * 0.46, h * 0.54, w * 0.5, h * 0.47)
      ..quadraticBezierTo(w * 0.54, h * 0.54, w * 0.58, h * 0.48);
    canvas.drawPath(smile, stroke);

    // Collar
    final collar = Path()
      ..moveTo(w * 0.36, h * 0.62)
      ..lineTo(w * 0.64, h * 0.62)
      ..lineTo(w * 0.62, h * 0.67)
      ..lineTo(w * 0.38, h * 0.67)
      ..close();
    canvas.drawPath(collar, fill);
    canvas.drawPath(collar, stroke);
    canvas.drawCircle(Offset(w * 0.5, h * 0.70), w * 0.025, stroke);
  }

  // --- KITTEN ---
  void _paintKitten(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Body
    final body = Path()
      ..moveTo(w * 0.34, h * 0.64)
      ..quadraticBezierTo(w * 0.24, h * 0.90, w * 0.45, h * 0.92)
      ..lineTo(w * 0.58, h * 0.92)
      ..quadraticBezierTo(w * 0.76, h * 0.90, w * 0.66, h * 0.64);
    canvas.drawPath(body, fill);
    canvas.drawPath(body, stroke);

    // Pointy Ears
    final leftEar = Path()
      ..moveTo(w * 0.32, h * 0.36)
      ..lineTo(w * 0.28, h * 0.16)
      ..lineTo(w * 0.45, h * 0.26)
      ..close();
    canvas.drawPath(leftEar, fill);
    canvas.drawPath(leftEar, stroke);

    final rightEar = Path()
      ..moveTo(w * 0.68, h * 0.36)
      ..lineTo(w * 0.72, h * 0.16)
      ..lineTo(w * 0.55, h * 0.26)
      ..close();
    canvas.drawPath(rightEar, fill);
    canvas.drawPath(rightEar, stroke);

    // Head
    canvas.drawCircle(Offset(w * 0.5, h * 0.42), w * 0.22, fill);
    canvas.drawCircle(Offset(w * 0.5, h * 0.42), w * 0.22, stroke);

    // Eyes
    canvas.drawCircle(Offset(w * 0.40, h * 0.38), w * 0.035, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.60, h * 0.38), w * 0.035, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.39, h * 0.37), w * 0.012, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.59, h * 0.37), w * 0.012, Paint()..color = Colors.white);

    // Nose & Smile
    canvas.drawCircle(Offset(w * 0.50, h * 0.45), w * 0.018, Paint()..color = outlineColor);
    final smile = Path()
      ..moveTo(w * 0.44, h * 0.50)
      ..quadraticBezierTo(w * 0.47, h * 0.54, w * 0.50, h * 0.48)
      ..quadraticBezierTo(w * 0.53, h * 0.54, w * 0.56, h * 0.50);
    canvas.drawPath(smile, stroke);

    // Whiskers
    canvas.drawLine(Offset(w * 0.42, h * 0.46), Offset(w * 0.24, h * 0.43), stroke);
    canvas.drawLine(Offset(w * 0.42, h * 0.50), Offset(w * 0.25, h * 0.52), stroke);
    canvas.drawLine(Offset(w * 0.58, h * 0.46), Offset(w * 0.76, h * 0.43), stroke);
    canvas.drawLine(Offset(w * 0.58, h * 0.50), Offset(w * 0.75, h * 0.52), stroke);
  }

  // --- ROCKET ---
  void _paintRocket(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Rocket Body
    final rocket = Path()
      ..moveTo(w * 0.50, h * 0.10) // Nose tip
      ..cubicTo(w * 0.68, h * 0.25, w * 0.68, h * 0.62, w * 0.62, h * 0.72)
      ..lineTo(w * 0.38, h * 0.72)
      ..cubicTo(w * 0.32, h * 0.62, w * 0.32, h * 0.25, w * 0.50, h * 0.10);
    canvas.drawPath(rocket, fill);
    canvas.drawPath(rocket, stroke);

    // Nose Cone stripe
    final noseStripe = Path()
      ..moveTo(w * 0.42, h * 0.25)
      ..quadraticBezierTo(w * 0.50, h * 0.28, w * 0.58, h * 0.25);
    canvas.drawPath(noseStripe, stroke);

    // Porthole Window
    canvas.drawCircle(Offset(w * 0.50, h * 0.42), w * 0.10, fill);
    canvas.drawCircle(Offset(w * 0.50, h * 0.42), w * 0.10, stroke);
    canvas.drawCircle(Offset(w * 0.50, h * 0.42), w * 0.06, stroke);

    // Left Fin
    final leftFin = Path()
      ..moveTo(w * 0.34, h * 0.55)
      ..lineTo(w * 0.18, h * 0.76)
      ..lineTo(w * 0.35, h * 0.72)
      ..close();
    canvas.drawPath(leftFin, fill);
    canvas.drawPath(leftFin, stroke);

    // Right Fin
    final rightFin = Path()
      ..moveTo(w * 0.66, h * 0.55)
      ..lineTo(w * 0.82, h * 0.76)
      ..lineTo(w * 0.65, h * 0.72)
      ..close();
    canvas.drawPath(rightFin, fill);
    canvas.drawPath(rightFin, stroke);

    // Flames
    final flame = Path()
      ..moveTo(w * 0.42, h * 0.72)
      ..lineTo(w * 0.38, h * 0.88)
      ..lineTo(w * 0.46, h * 0.82)
      ..lineTo(w * 0.50, h * 0.94)
      ..lineTo(w * 0.54, h * 0.82)
      ..lineTo(w * 0.62, h * 0.88)
      ..lineTo(w * 0.58, h * 0.72);
    canvas.drawPath(flame, stroke);

    // Stars around
    _drawStar(canvas, Offset(w * 0.20, h * 0.22), w * 0.04, stroke);
    _drawStar(canvas, Offset(w * 0.80, h * 0.30), w * 0.05, stroke);
  }

  // --- ALIEN ---
  void _paintAlien(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Flying saucer dome
    final saucerDome = Path()
      ..moveTo(w * 0.32, h * 0.50)
      ..cubicTo(w * 0.32, h * 0.26, w * 0.68, h * 0.26, w * 0.68, h * 0.50);
    canvas.drawPath(saucerDome, fill);
    canvas.drawPath(saucerDome, stroke);

    // Cute Alien Inside
    canvas.drawCircle(Offset(w * 0.5, h * 0.42), w * 0.11, stroke);
    // Alien Eye
    canvas.drawCircle(Offset(w * 0.5, h * 0.40), w * 0.035, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.49, h * 0.39), w * 0.012, Paint()..color = Colors.white);
    // Antenna
    canvas.drawLine(Offset(w * 0.5, h * 0.31), Offset(w * 0.5, h * 0.24), stroke);
    canvas.drawCircle(Offset(w * 0.5, h * 0.23), w * 0.02, stroke);

    // Saucer Base
    final saucerBase = Path()
      ..moveTo(w * 0.15, h * 0.58)
      ..cubicTo(w * 0.25, h * 0.46, w * 0.75, h * 0.46, w * 0.85, h * 0.58)
      ..cubicTo(w * 0.75, h * 0.70, w * 0.25, h * 0.70, w * 0.15, h * 0.58);
    canvas.drawPath(saucerBase, fill);
    canvas.drawPath(saucerBase, stroke);

    // Saucer lights
    canvas.drawCircle(Offset(w * 0.28, h * 0.58), w * 0.03, stroke);
    canvas.drawCircle(Offset(w * 0.50, h * 0.60), w * 0.03, stroke);
    canvas.drawCircle(Offset(w * 0.72, h * 0.58), w * 0.03, stroke);
  }

  // --- DOLPHIN ---
  void _paintDolphin(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Dolphin Arching Body
    final body = Path()
      ..moveTo(w * 0.18, h * 0.50) // Beak
      ..cubicTo(w * 0.28, h * 0.25, w * 0.65, h * 0.22, w * 0.85, h * 0.60) // Back
      ..lineTo(w * 0.92, h * 0.54) // Upper Fluke
      ..lineTo(w * 0.88, h * 0.65)
      ..lineTo(w * 0.94, h * 0.72) // Lower Fluke
      ..cubicTo(w * 0.68, h * 0.52, w * 0.42, h * 0.52, w * 0.25, h * 0.56) // Belly
      ..close();
    canvas.drawPath(body, fill);
    canvas.drawPath(body, stroke);

    // Dorsal Fin
    final dorsal = Path()
      ..moveTo(w * 0.50, h * 0.26)
      ..cubicTo(w * 0.55, h * 0.14, w * 0.62, h * 0.15, w * 0.64, h * 0.28);
    canvas.drawPath(dorsal, stroke);

    // Flipper
    final flipper = Path()
      ..moveTo(w * 0.38, h * 0.48)
      ..cubicTo(w * 0.44, h * 0.58, w * 0.48, h * 0.56, w * 0.45, h * 0.46);
    canvas.drawPath(flipper, stroke);

    // Eye & Smile
    canvas.drawCircle(Offset(w * 0.28, h * 0.42), w * 0.025, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.27, h * 0.41), w * 0.008, Paint()..color = Colors.white);

    // Ocean Waves below
    final waves = Path()
      ..moveTo(w * 0.10, h * 0.85)
      ..quadraticBezierTo(w * 0.25, h * 0.78, w * 0.40, h * 0.85)
      ..quadraticBezierTo(w * 0.55, h * 0.92, w * 0.70, h * 0.85)
      ..quadraticBezierTo(w * 0.85, h * 0.78, w * 0.95, h * 0.85);
    canvas.drawPath(waves, stroke);
  }

  // --- TURTLE ---
  void _paintTurtle(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Shell
    final shellRect = Rect.fromCenter(center: Offset(w * 0.50, h * 0.48), width: w * 0.55, height: h * 0.40);
    canvas.drawOval(shellRect, fill);
    canvas.drawOval(shellRect, stroke);

    // Shell Plates / Hexagon Patterns
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.50, h * 0.48), width: w * 0.25, height: h * 0.20), stroke);
    canvas.drawLine(Offset(w * 0.50, h * 0.28), Offset(w * 0.50, h * 0.38), stroke);
    canvas.drawLine(Offset(w * 0.50, h * 0.58), Offset(w * 0.50, h * 0.68), stroke);
    canvas.drawLine(Offset(w * 0.37, h * 0.48), Offset(w * 0.22, h * 0.48), stroke);
    canvas.drawLine(Offset(w * 0.63, h * 0.48), Offset(w * 0.78, h * 0.48), stroke);

    // Head
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.82, h * 0.44), width: w * 0.18, height: h * 0.15), fill);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.82, h * 0.44), width: w * 0.18, height: h * 0.15), stroke);
    canvas.drawCircle(Offset(w * 0.86, h * 0.40), w * 0.025, Paint()..color = outlineColor);

    // Flippers
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.60, h * 0.26), width: w * 0.22, height: h * 0.10), stroke);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.35, h * 0.28), width: w * 0.18, height: h * 0.09), stroke);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.60, h * 0.70), width: w * 0.22, height: h * 0.10), stroke);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.35, h * 0.68), width: w * 0.18, height: h * 0.09), stroke);
  }

  // --- DINO ---
  void _paintDino(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;

    // Dino Body & Tail
    final body = Path()
      ..moveTo(w * 0.32, h * 0.35)
      ..cubicTo(w * 0.18, h * 0.35, w * 0.16, h * 0.22, w * 0.32, h * 0.20)
      ..cubicTo(w * 0.42, h * 0.20, w * 0.42, h * 0.32, w * 0.48, h * 0.45)
      ..cubicTo(w * 0.68, h * 0.45, w * 0.78, h * 0.62, w * 0.90, h * 0.70) // Tail
      ..lineTo(w * 0.84, h * 0.78)
      ..cubicTo(w * 0.68, h * 0.78, w * 0.55, h * 0.85, w * 0.45, h * 0.88)
      ..lineTo(w * 0.36, h * 0.88)
      ..cubicTo(w * 0.30, h * 0.75, w * 0.32, h * 0.55, w * 0.32, h * 0.35);
    canvas.drawPath(body, fill);
    canvas.drawPath(body, stroke);

    // Eye
    canvas.drawCircle(Offset(w * 0.26, h * 0.26), w * 0.025, Paint()..color = outlineColor);
    canvas.drawCircle(Offset(w * 0.25, h * 0.25), w * 0.008, Paint()..color = Colors.white);

    // Cute Back Spikes
    final spikes = Path()
      ..moveTo(w * 0.42, h * 0.38)
      ..lineTo(w * 0.45, h * 0.32)
      ..lineTo(w * 0.48, h * 0.42)
      ..lineTo(w * 0.54, h * 0.36)
      ..lineTo(w * 0.58, h * 0.48)
      ..lineTo(w * 0.66, h * 0.42)
      ..lineTo(w * 0.70, h * 0.56);
    canvas.drawPath(spikes, stroke);
  }

  // --- BUTTERFLY ---
  void _paintButterfly(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;
    final cy = h * 0.52;

    // Left Upper Wing
    final leftUpper = Path()
      ..moveTo(cx - 8, cy - 20)
      ..cubicTo(w * 0.10, h * 0.10, w * 0.08, h * 0.45, cx - 8, cy + 10);
    canvas.drawPath(leftUpper, fill);
    canvas.drawPath(leftUpper, stroke);
    canvas.drawCircle(Offset(w * 0.26, h * 0.32), w * 0.06, stroke);

    // Right Upper Wing
    final rightUpper = Path()
      ..moveTo(cx + 8, cy - 20)
      ..cubicTo(w * 0.90, h * 0.10, w * 0.92, h * 0.45, cx + 8, cy + 10);
    canvas.drawPath(rightUpper, fill);
    canvas.drawPath(rightUpper, stroke);
    canvas.drawCircle(Offset(w * 0.74, h * 0.32), w * 0.06, stroke);

    // Left Lower Wing
    final leftLower = Path()
      ..moveTo(cx - 8, cy + 10)
      ..cubicTo(w * 0.15, h * 0.65, w * 0.30, h * 0.85, cx - 4, cy + 50);
    canvas.drawPath(leftLower, fill);
    canvas.drawPath(leftLower, stroke);

    // Right Lower Wing
    final rightLower = Path()
      ..moveTo(cx + 8, cy + 10)
      ..cubicTo(w * 0.85, h * 0.65, w * 0.70, h * 0.85, cx + 4, cy + 50);
    canvas.drawPath(rightLower, fill);
    canvas.drawPath(rightLower, stroke);

    // Body & Head
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(cx, cy + 10), width: 16, height: 75), const Radius.circular(8)), fill);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(cx, cy + 10), width: 16, height: 75), const Radius.circular(8)), stroke);
    canvas.drawCircle(Offset(cx, cy - 32), 12, fill);
    canvas.drawCircle(Offset(cx, cy - 32), 12, stroke);

    // Antennae
    final antLeft = Path()
      ..moveTo(cx - 4, cy - 42)
      ..quadraticBezierTo(cx - 24, cy - 65, cx - 32, cy - 58);
    canvas.drawPath(antLeft, stroke);
    canvas.drawCircle(Offset(cx - 32, cy - 58), 4, Paint()..color = outlineColor);

    final antRight = Path()
      ..moveTo(cx + 4, cy - 42)
      ..quadraticBezierTo(cx + 24, cy - 65, cx + 32, cy - 58);
    canvas.drawPath(antRight, stroke);
    canvas.drawCircle(Offset(cx + 32, cy - 58), 4, Paint()..color = outlineColor);
  }

  // --- RAINBOW ---
  void _paintRainbow(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.72);

    // Rainbow Arches
    final r1 = w * 0.40;
    final r2 = w * 0.32;
    final r3 = w * 0.24;
    final r4 = w * 0.16;

    final rect1 = Rect.fromCircle(center: center, radius: r1);
    final rect2 = Rect.fromCircle(center: center, radius: r2);
    final rect3 = Rect.fromCircle(center: center, radius: r3);
    final rect4 = Rect.fromCircle(center: center, radius: r4);

    canvas.drawArc(rect1, math.pi, math.pi, false, stroke);
    canvas.drawArc(rect2, math.pi, math.pi, false, stroke);
    canvas.drawArc(rect3, math.pi, math.pi, false, stroke);
    canvas.drawArc(rect4, math.pi, math.pi, false, stroke);

    // Left Cloud
    _drawCloud(canvas, Offset(w * 0.22, h * 0.72), w * 0.12, stroke, fill);
    // Right Cloud
    _drawCloud(canvas, Offset(w * 0.78, h * 0.72), w * 0.12, stroke, fill);

    // Smiling Sun
    final sunCenter = Offset(w * 0.20, h * 0.25);
    canvas.drawCircle(sunCenter, w * 0.08, fill);
    canvas.drawCircle(sunCenter, w * 0.08, stroke);
    // Sun rays
    for (int i = 0; i < 8; i++) {
      final angle = (i * 2 * math.pi) / 8;
      final p1 = Offset(sunCenter.dx + w * 0.09 * math.cos(angle), sunCenter.dy + w * 0.09 * math.sin(angle));
      final p2 = Offset(sunCenter.dx + w * 0.13 * math.cos(angle), sunCenter.dy + w * 0.13 * math.sin(angle));
      canvas.drawLine(p1, p2, stroke);
    }
  }

  void _drawCloud(Canvas canvas, Offset center, double size, Paint stroke, Paint fill) {
    canvas.drawCircle(center, size * 0.8, fill);
    canvas.drawCircle(center + Offset(-size * 0.6, size * 0.2), size * 0.6, fill);
    canvas.drawCircle(center + Offset(size * 0.6, size * 0.2), size * 0.6, fill);

    canvas.drawCircle(center, size * 0.8, stroke);
    canvas.drawCircle(center + Offset(-size * 0.6, size * 0.2), size * 0.6, stroke);
    canvas.drawCircle(center + Offset(size * 0.6, size * 0.2), size * 0.6, stroke);
  }

  void _paintBlankCanvas(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = const Color(0xFFDDD2A5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(16, 16, size.width - 32, size.height - 32),
        const Radius.circular(20),
      ),
      borderPaint,
    );
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint stroke) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final outerAngle = (i * 4 * math.pi) / 5 - math.pi / 2;
      final innerAngle = outerAngle + math.pi / 5;
      final pOuter = Offset(center.dx + radius * math.cos(outerAngle), center.dy + radius * math.sin(outerAngle));
      final pInner = Offset(center.dx + radius * 0.45 * math.cos(innerAngle), center.dy + radius * 0.45 * math.sin(innerAngle));
      if (i == 0) {
        path.moveTo(pOuter.dx, pOuter.dy);
      } else {
        path.lineTo(pOuter.dx, pOuter.dy);
      }
      path.lineTo(pInner.dx, pInner.dy);
    }
    path.close();
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant TemplatePainter oldDelegate) {
    return oldDelegate.templateId != templateId ||
        oldDelegate.outlineColor != outlineColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.fillShapes != fillShapes;
  }
}
