import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedCountdownRing extends StatefulWidget {
  final Duration duration;
  final Duration totalDuration;
  final Color color;

  const AnimatedCountdownRing({
    Key? key,
    required this.duration,
    required this.totalDuration,
    required this.color,
  }) : super(key: key);

  @override
  State<AnimatedCountdownRing> createState() =>
      _AnimatedCountdownRingState();
}

class _AnimatedCountdownRingState
    extends State<AnimatedCountdownRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get progress {
    final total = widget.totalDuration.inSeconds;
    final remaining = widget.duration.inSeconds;

    if (total == 0) return 0;
    return 1 - (remaining / total).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _RingPainter(
            progress: progress,
            color: widget.color,
            sweepAnimation: _controller.value,
          ),
          child: Center(
            child: Text(
              "${widget.duration.inHours.toString().padLeft(2, '0')} : "
              "${widget.duration.inMinutes.remainder(60).toString().padLeft(2, '0')} : "
              "${widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
              style: GoogleFonts.cormorantGaramond(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double sweepAnimation;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.sweepAnimation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final basePaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..shader = SweepGradient(
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        colors: [
          color.withOpacity(0.2),
          color,
        ],
        stops: const [0.0, 1.0],
        transform: GradientRotation(sweepAnimation * 2 * pi),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Background ring
    canvas.drawCircle(center, radius, basePaint);

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.sweepAnimation != sweepAnimation;
}