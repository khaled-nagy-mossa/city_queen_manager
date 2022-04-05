import 'package:branch_manager/common/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Stock extends StatelessWidget {
  const Stock({@required this.count, Key key}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${count ?? 0}'),
        const SizedBox(width: 2.0),
        SvgPicture.asset(
          Assets.images.stock,
          height: 20.0,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
