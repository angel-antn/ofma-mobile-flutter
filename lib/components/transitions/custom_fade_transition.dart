import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomFadeTransition extends CustomTransitionPage {
  CustomFadeTransition({
    required Widget child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: child,
        );
}
