import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/const/app_data.dart';
import '../../chat/common/chat_view_imports.dart';

class CollectedMoneyItem extends StatelessWidget {
  final String svgPath;
  final String title;
  final String money;
  final TextStyle style;

  const CollectedMoneyItem({
    @required this.svgPath,
    @required this.title,
    @required this.money,
    this.style,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 70.0,
          minHeight: 70.0,
        ),
        child: ListTile(
          leading: Container(
            constraints: const BoxConstraints(maxHeight: 55.0, maxWidth: 55.0),
            decoration: BoxDecoration(
              gradient: AppData.gradient,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(svgPath, color: Colors.white),
          ),
          title: Text(
            title,
            style: style ??
                const TextStyle(
                  color: AppData.secondaryColor,
                  fontSize: 10.0,
                ),
          ),
          subtitle: Text(
            money,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
