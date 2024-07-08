import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

class FadeTransitionWidget extends StatelessWidget {
  final Widget child;

  FadeTransitionWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimatedWidget.tween(
      enabled: true,
      opacityDisabled: 0.0,
      opacityEnabled: 1.0,
      child: child,
    );
  }
}
