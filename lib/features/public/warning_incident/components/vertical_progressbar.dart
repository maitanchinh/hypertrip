import 'package:flutter/material.dart';

class VerticalProgressBar extends StatefulWidget {
  final double value;
  final Color color;
  final Color backgroundColor;
  final double height;
  final Duration animationDuration;

  const VerticalProgressBar({
    Key? key,
    required this.value,
    this.color = Colors.blue,
    this.backgroundColor = Colors.blue,
    this.height = 75.0,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _VerticalProgressBarState createState() => _VerticalProgressBarState();
}

class _VerticalProgressBarState extends State<VerticalProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.value,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void didUpdateWidget(VerticalProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: oldWidget.value,
        end: widget.value,
      ).animate(_animationController);

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: widget.backgroundColor, width: 0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return RotatedBox(
              quarterTurns: -1,
              child: LinearProgressIndicator(
                value: _animation.value,
                backgroundColor: widget.backgroundColor,
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              ),
            );
          },
        ),
      ),
    );
  }
}
