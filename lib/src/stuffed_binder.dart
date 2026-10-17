import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A closed three-ring binder bowed outward by the papers packed inside it.
class StuffedBinder extends StatelessWidget {
  const StuffedBinder({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Overstuffed binder',
      child: const CustomPaint(
        painter: _StuffedBinderPainter(),
        child: SizedBox.expand(),
      ),
    );
  }
}

class _StuffedBinderPainter extends CustomPainter {
  const _StuffedBinderPainter();

  static const _design = Size(340, 430);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(
      size.width / _design.width,
      size.height / _design.height,
    );
    canvas.save();
    canvas.translate(
      (size.width - _design.width * scale) / 2,
      (size.height - _design.height * scale) / 2,
    );
    canvas.scale(scale);
    _paintDesign(canvas);
    canvas.restore();
  }

  void _paintDesign(Canvas canvas) {
    _shadow(canvas);
    _pencil(canvas);
    _looseSheets(canvas);
    _ribbon(canvas);
    _pageStack(canvas);
    _tabs(canvas);
    _spine(canvas);
    _cover(canvas);
    _label(canvas);
    _stickyNote(canvas);
    _band(canvas);
  }

  void _shadow(Canvas canvas) {
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(176, 396),
        width: 240,
        height: 28,
      ),
      Paint()
        ..color = const Color(0x38000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );
  }

  void _looseSheets(Canvas canvas) {
    const sheets = [
      _Sheet(
        Rect.fromLTWH(78, 78, 118, 96),
        Color(0xFFF4E7A8),
        -0.22,
        lined: true,
      ),
      _Sheet(
        Rect.fromLTWH(168, 62, 108, 78),
        Color(0xFFD7E4EA),
        0.1,
        grid: true,
      ),
      _Sheet(
        Rect.fromLTWH(118, 96, 150, 64),
        Color(0xFFE4C48A),
        -0.04,
      ),
      _Sheet(
        Rect.fromLTWH(186, 46, 72, 86),
        Color(0xFFF7F4EE),
        0.16,
        photo: true,
      ),
      _Sheet(
        Rect.fromLTWH(58, 118, 78, 48),
        Color(0xFFE7B7B0),
        -0.32,
        lined: true,
      ),
      _Sheet(
        Rect.fromLTWH(228, 132, 86, 108),
        Color(0xFFF7F1E6),
        0.2,
        lined: true,
      ),
      _Sheet(
        Rect.fromLTWH(214, 214, 78, 92),
        Color(0xFFD5DDD0),
        0.08,
      ),
      _Sheet(
        Rect.fromLTWH(132, 328, 128, 36),
        Color(0xFFF3E6C8),
        0.03,
      ),
    ];

    for (final sheet in sheets) {
      _drawSheet(canvas, sheet);
    }
  }

  void _drawSheet(Canvas canvas, _Sheet sheet) {
    canvas.save();
    canvas.translate(sheet.rect.center.dx, sheet.rect.center.dy);
    canvas.rotate(sheet.angle);
    final local = Rect.fromCenter(
      center: Offset.zero,
      width: sheet.rect.width,
      height: sheet.rect.height,
    );
    final rrect = RRect.fromRectAndRadius(local, const Radius.circular(2));

    canvas.drawRRect(
      rrect.shift(const Offset(1.2, 2)),
      Paint()
        ..color = const Color(0x2A000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    canvas.drawRRect(rrect, Paint()..color = sheet.color);
    canvas.save();
    canvas.clipRRect(rrect);

    if (sheet.lined) {
      final line = Paint()
        ..color = const Color(0x556B5344)
        ..strokeWidth = 0.7;
      for (var y = local.top + 10; y < local.bottom - 6; y += 6) {
        canvas.drawLine(Offset(local.left + 6, y), Offset(local.right - 6, y), line);
      }
    }

    if (sheet.grid) {
      final line = Paint()
        ..color = const Color(0x447C93A0)
        ..strokeWidth = 0.6;
      for (var y = local.top + 8; y < local.bottom - 4; y += 7) {
        canvas.drawLine(Offset(local.left + 4, y), Offset(local.right - 4, y), line);
      }
      for (var x = local.left + 8; x < local.right - 4; x += 7) {
        canvas.drawLine(Offset(x, local.top + 4), Offset(x, local.bottom - 4), line);
      }
    }

    if (sheet.photo) {
      final image = local.deflate(7);
      canvas.drawRect(image, Paint()..color = const Color(0xFFB7D0CE));
      canvas.drawRect(
        Rect.fromLTRB(image.left, image.center.dy + 2, image.right, image.bottom),
        Paint()..color = const Color(0xFF6E8B62),
      );
      canvas.drawCircle(
        image.center.translate(8, -8),
        6,
        Paint()..color = const Color(0xFFF3E3A2),
      );
    }

    canvas.restore();
    canvas.restore();
  }

  void _ribbon(Canvas canvas) {
    final ribbon = Path()
      ..moveTo(168, 338)
      ..lineTo(168, 404)
      ..lineTo(178, 392)
      ..lineTo(188, 404)
      ..lineTo(188, 338)
      ..close();
    canvas.drawPath(ribbon, Paint()..color = const Color(0xFF8C2F2A));
    canvas.drawPath(
      Path()
        ..moveTo(168, 338)
        ..lineTo(174, 338)
        ..lineTo(174, 398)
        ..lineTo(168, 404)
        ..close(),
      Paint()..color = const Color(0xFF6E221E),
    );
  }

  void _pageStack(Canvas canvas) {
    const layers = 16;
    for (var i = layers - 1; i >= 0; i--) {
      final spread = i / (layers - 1);
      canvas.drawPath(
        _pagePath(spread),
        Paint()
          ..color = i.isEven ? const Color(0xFFF7F1E4) : const Color(0xFFE4D5C0),
      );
    }
  }

  Path _pagePath(double spread) {
    final top = 132 - spread * 30;
    final bottom = 346 + spread * 18;
    final right = 236 + spread * 70;
    final rightTop = 228 + spread * 36;
    final rightBot = 220 + spread * 28;
    const left = 116.0;
    return Path()
      ..moveTo(left, top + 6)
      ..cubicTo(168, top - 4, 206, top + 2, rightTop, top + 18)
      ..cubicTo(right + 8, 196, right, 286, rightBot, bottom - 12)
      ..cubicTo(196, bottom + 8, 154, bottom + 2, left, bottom - 4)
      ..close();
  }

  void _tabs(Canvas canvas) {
    const tabs = <(double, Color)>[
      (176, Color(0xFFB64A3C)),
      (222, Color(0xFFD2A24A)),
      (268, Color(0xFF5E7D55)),
    ];
    for (final (y, color) in tabs) {
      final rect = RRect.fromRectAndCorners(
        Rect.fromLTWH(286, y, 46, 30),
        topRight: const Radius.circular(4),
        bottomRight: const Radius.circular(4),
      );
      canvas.drawRRect(
        rect.shift(const Offset(1, 1.5)),
        Paint()
          ..color = const Color(0x22000000)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
      );
      canvas.drawRRect(rect, Paint()..color = color);
    }
  }

  void _spine(Canvas canvas) {
    final spine = Path()
      ..moveTo(124, 134)
      ..lineTo(100, 140)
      ..quadraticBezierTo(74, 148, 74, 166)
      ..lineTo(74, 314)
      ..quadraticBezierTo(74, 340, 102, 346)
      ..lineTo(124, 342)
      ..close();
    canvas.drawPath(
      spine,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF4A261E), Color(0xFF7A4638), Color(0xFF3F201A)],
        ).createShader(const Rect.fromLTWH(74, 134, 50, 212)),
    );

    for (final y in [188.0, 242.0, 296.0]) {
      final housing = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(94, y), width: 12, height: 26),
        const Radius.circular(4),
      );
      canvas.drawRRect(housing, Paint()..color = const Color(0xFF8A8681));
      canvas.drawRRect(
        housing.deflate(2.2),
        Paint()..color = const Color(0xFFE4E0DA),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(94, y), width: 3, height: 14),
          const Radius.circular(1),
        ),
        Paint()..color = const Color(0xFF6E6A66),
      );
    }
  }

  void _cover(Canvas canvas) {
    final cover = RRect.fromRectAndRadius(
      const Rect.fromLTWH(112, 134, 158, 208),
      const Radius.circular(14),
    );
    final bounds = cover.outerRect;

    canvas.drawRRect(
      cover,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8E5646), Color(0xFF6B3B2E), Color(0xFF4E291F)],
          stops: [0, 0.55, 1],
        ).createShader(bounds),
    );
    canvas.drawRRect(
      cover,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.45, -0.6),
          radius: 0.95,
          colors: [Color(0x55FFFFFF), Color(0x00FFFFFF)],
        ).createShader(bounds),
    );

    _dash(
      canvas,
      Path()..addRRect(cover.deflate(11)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..color = const Color(0xFF3A1E16),
    );
  }

  void _label(Canvas canvas) {
    final plate = RRect.fromRectAndRadius(
      const Rect.fromLTWH(148, 178, 92, 54),
      const Radius.circular(3),
    );
    canvas.drawRRect(
      plate.inflate(3),
      Paint()..color = const Color(0xFFC6A56A),
    );
    canvas.drawRRect(plate, Paint()..color = const Color(0xFFF6F1E4));

    final ink = Paint()
      ..color = const Color(0xFF5C4636)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path()
        ..moveTo(160, 194)
        ..quadraticBezierTo(176, 190, 196, 195)
        ..quadraticBezierTo(214, 199, 226, 193),
      ink,
    );
    canvas.drawPath(
      Path()
        ..moveTo(162, 208)
        ..quadraticBezierTo(184, 204, 208, 209)
        ..quadraticBezierTo(220, 212, 224, 207),
      ink,
    );
    canvas.drawPath(
      Path()
        ..moveTo(160, 220)
        ..quadraticBezierTo(178, 217, 198, 221),
      ink,
    );
  }

  void _stickyNote(Canvas canvas) {
    canvas.save();
    canvas.translate(214, 286);
    canvas.rotate(0.08);
    final note = RRect.fromRectAndRadius(
      const Rect.fromLTWH(-30, -26, 64, 54),
      const Radius.circular(2),
    );
    canvas.drawRRect(note, Paint()..color = const Color(0xFFF6E27A));
    final line = Paint()
      ..color = const Color(0x665C4636)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(-18, -8), const Offset(22, -6), line);
    canvas.drawLine(const Offset(-18, 2), const Offset(16, 4), line);
    canvas.drawLine(const Offset(-18, 12), const Offset(8, 13), line);
    canvas.restore();
  }

  void _band(Canvas canvas) {
    final band = Path()
      ..moveTo(64, 248)
      ..quadraticBezierTo(180, 226, 318, 252);
    canvas.drawPath(
      band,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round
        ..color = const Color(0xFF3A241C),
    );
    canvas.drawPath(
      band.shift(const Offset(0, -2)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..color = const Color(0x55E8D7C4),
    );
  }

  void _pencil(Canvas canvas) {
    canvas.save();
    canvas.translate(78, 168);
    canvas.rotate(-0.12);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-4, -78, 9, 16),
        const Radius.circular(2),
      ),
      Paint()..color = const Color(0xFFC46B6B),
    );
    canvas.drawRect(
      const Rect.fromLTWH(-4, -64, 9, 5),
      Paint()..color = const Color(0xFFD5D0C8),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-4, -60, 9, 108),
        const Radius.circular(1.5),
      ),
      Paint()..color = const Color(0xFFE2B04A),
    );
    canvas.drawPath(
      Path()
        ..moveTo(-4, 48)
        ..lineTo(0.5, 66)
        ..lineTo(5, 48)
        ..close(),
      Paint()..color = const Color(0xFFC9854A),
    );
    canvas.drawPath(
      Path()
        ..moveTo(-1.4, 58)
        ..lineTo(0.5, 66)
        ..lineTo(2.4, 58)
        ..close(),
      Paint()..color = const Color(0xFF2C211C),
    );
    canvas.restore();
  }

  void _dash(Canvas canvas, Path path, Paint paint) {
    const dash = 3.0;
    const gap = 3.2;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = math.min(distance + dash, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Sheet {
  const _Sheet(
    this.rect,
    this.color,
    this.angle, {
    this.lined = false,
    this.grid = false,
    this.photo = false,
  });

  final Rect rect;
  final Color color;
  final double angle;
  final bool lined;
  final bool grid;
  final bool photo;
}
