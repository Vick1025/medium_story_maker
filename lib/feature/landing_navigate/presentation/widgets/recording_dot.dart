import 'package:flutter/material.dart';

class RecordingDot extends StatefulWidget {
  const RecordingDot({super.key});

  @override
  State<RecordingDot> createState() => _RecordingDotState();
}

class _RecordingDotState extends State<RecordingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.red.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2 + (_controller.value * 0.8)),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
