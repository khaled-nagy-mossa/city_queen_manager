import 'package:flutter/material.dart';

import '../../../common/const/app_data.dart';

class AddProductViewFAB extends StatelessWidget {
  final VoidCallback onTap;

  const AddProductViewFAB({@required this.onTap, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Next',
      onPressed: () {
        if (onTap != null) onTap();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppData.gradient,
        ),
        child: const Icon(Icons.navigate_next, size: 40),
      ),
    );
  }
}
