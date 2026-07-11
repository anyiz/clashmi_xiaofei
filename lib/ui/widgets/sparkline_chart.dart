import 'package:flutter/material.dart';
import 'package:clashmi/screens/theme_define.dart';

class SparklineChart extends StatelessWidget {
  final List<double> data;
  final Color? color;
  final double strokeWidth;
  final double height;
  final double width;

  const SparklineChart({
    super.key,
    required this.data,
    this.color,
    this.strokeWidth = 2,
    this.height = 40,
    this.width = 80,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(width: width, height: height);
    }

    return CustomPaint(
      size: Size(width, height),
      painter: _SparklinePainter(
        data: data,
        color: color ?? ThemeDefine.kPrimary,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final double strokeWidth;

  _SparklinePainter({
    required this.data,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.3),
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final minVal = data.reduce((a, b) => a < b ? a : b);
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    final range = maxVal - minVal > 0 ? maxVal - minVal : 1.0;

    final path = Path();
    final fillPath = Path();

    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - ((data[i] - minVal) / range) * size.height * 0.8;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // Draw fill
    fillPath.lineTo(size.width, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw line
    canvas.drawPath(path, paint);

    // Draw latest dot
    final lastX = size.width;
    final lastY =
        size.height -
        ((data.last - minVal) / range) * size.height * 0.8;
    canvas.drawCircle(
      Offset(lastX, lastY),
      strokeWidth + 1,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_SparklinePainter oldDelegate) {
    return oldDelegate.data != data;
  }
}
