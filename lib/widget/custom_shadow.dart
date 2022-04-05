import 'package:flutter/material.dart';

class CustomShadow extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double radius;

  const CustomShadow({
    @required this.child,
    this.elevation = 0.0,
    this.radius = 15.0,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 15.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.1,
            blurRadius: 7,
          ),
        ],
      ),
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 15.0),
        ),
        child: child,
      ),
    );
  }
}
