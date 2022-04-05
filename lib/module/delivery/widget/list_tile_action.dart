import 'package:branch_manager/main_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListTileAction extends StatelessWidget {
  const ListTileAction({
    @required this.onTap,
    @required this.svg,
    this.hint,
    Key key,
  }) : super(key: key);

  final String svg;

  final VoidCallback onTap;

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: hint ?? '',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 35.0,
          width: 35.0,
          padding: const EdgeInsets.all(7.0),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppData.customGradient,
          ),
          child: SvgPicture.asset(svg, color: Colors.white),
        ),
      ),
    );
  }
}
