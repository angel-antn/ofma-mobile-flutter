import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SwipeToRightTransition extends CustomTransitionPage {
  SwipeToRightTransition({
    required Widget child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.5, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.ease),
                ),
              ),
              child: child,
            );
          },
          child: child,
        );
}
