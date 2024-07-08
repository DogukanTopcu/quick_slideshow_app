import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

class ScaleTransitionWidget extends StatelessWidget {
  final Widget child;

  ScaleTransitionWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedWidget.tween(
      enabled: true,
      scaleDisabled: 0.5,
      scaleEnabled: 1.0,
      child: child,
    );
  }
}
