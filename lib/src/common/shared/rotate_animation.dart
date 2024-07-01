import 'dart:math';
import 'package:flutter/material.dart';

/// Defines the direction in which the rotation should take place.
///**
/// INI UNTUK SEMUA
/// */
enum RotationDirection {
  clockwise,
  anti_clockwise,
}

/// A widget which rotates its child(ren).
class RotateTut extends StatefulWidget {
  /// The item to be rotateTutd.
  final Widget? child;

  /// The number of rotations per minute. Defaults to 70.
  final int rotationsPerMinute;

  /// Whether to loop rotation or not.
  final bool repeat;

  /// The direction in which to rotateTut.
  final RotationDirection rotationDirection;

  RotateTut({
    required this.child,
    this.rotationsPerMinute = 70,
    this.repeat = false,
    this.rotationDirection = RotationDirection.clockwise,
  });

  @override
  State<StatefulWidget> createState() {
    return _RotateTutState();
  }
}

class _RotateTutState extends State<RotateTut>
    with SingleTickerProviderStateMixin {
  late AnimationController _contoller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    // When it comes to calculating the rotations per minute. 60000 milliseconds which make up a minute is divided by the number of rotationsPerMinute. At the time of this writing, it approximately produces the desired effect. It is quite possible that this division might result in a negative number or 0, in that case a default rotation of 70rpm (857 milliseconds approx.) is applied.

    _contoller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 600000 ~/ widget.rotationsPerMinute > 0
            ? 600000 ~/ widget.rotationsPerMinute
            : 10000,
      ),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween(begin: 0.0, end: pi * 2).animate(_contoller);

    _contoller.repeat();
  }

  @override
  void didUpdateWidget(RotateTut oldWidget) {
    _contoller.reset();
    _contoller.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _contoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value * 4,
      child: Container(
        child: widget.child,
      ),
    );
  }
}

//**
// INI UNTUK DI SPLASH SCREEN
// */
class RotateAnimationTut extends StatefulWidget {
  /// The item to be rotateAnimationTutd.
  final Widget? child;

  /// The number of rotations per minute. Defaults to 70.
  final double rotationsPerMinute;

  /// Whether to loop rotation or not.
  final int duration;

  /// The direction in which to rotateAnimationTut.
  final RotationDirection rotationDirection;

  const RotateAnimationTut({
    this.child,
    this.rotationsPerMinute = 5,
    this.duration = 8,
    this.rotationDirection = RotationDirection.clockwise,
  });

  @override
  State<StatefulWidget> createState() {
    return _RotateAnimationTutState();
  }
}

//**
// INI UNTUK DI SPLASH SCREEN
// */
class _RotateAnimationTutState extends State<RotateAnimationTut>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation animation;
  late double rotationPerminute;
  double uppBound = 10;
  double lowBound = 0;

  @override
  void initState() {
    super.initState();
    rotationPerminute = widget.rotationsPerMinute;
    // When it comes to calculating the rotations per minute. 60000 milliseconds which make up a minute is divided by the number of rotationsPerMinute. At the time of this writing, it approximately produces the desired effect. It is quite possible that this division might result in a negative number or 0, in that case a default rotation of 70rpm (857 milliseconds approx.) is applied.
    if (rotationPerminute >= uppBound) {
      throw FlutterError(
          'Rotation per minute can not bigger then uppbound(10)');
    }
    assert(rotationPerminute <= uppBound);
    assert(rotationPerminute >= lowBound);
    _animationController = AnimationController(
      upperBound: rotationPerminute,
      duration: Duration(
        seconds: widget.duration,
      ),
      vsync: this,
      // )..repeat();
    )..addListener(() {
        setState(() {});
      });

    animation = Tween(
            begin: widget.rotationDirection == RotationDirection.clockwise
                ? 0.0
                : pi * 2,
            end: widget.rotationDirection == RotationDirection.clockwise
                ? pi * 2
                : 0.0)
        .animate(_animationController);
    _animationController.repeat();
    // widget.repeat
    //     ? _animationController.repeat()
    //     : _animationController.forward();
  }

  @override
  void didUpdateWidget(RotateAnimationTut oldWidget) {
    _animationController.reset();
    _animationController.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value,
      child: Container(
        child: widget.child,
      ),
    );
  }
}
