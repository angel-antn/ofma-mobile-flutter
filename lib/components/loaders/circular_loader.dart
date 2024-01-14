import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({super.key, required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
